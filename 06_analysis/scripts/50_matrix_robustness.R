#!/usr/bin/env Rscript
# Sensitivities only: retain script 13 as the primary estimator.
source("06_analysis/scripts/49_matrix_concordance.R")
set.seed(20261007)
n_boot <- 2000L
surv_studies <- unique(as.character(cells$study))
grow_studies <- unique(as.character(growth$study))
shared <- intersect(surv_studies, grow_studies)
survival_only <- setdiff(surv_studies, shared)
stopifnot(length(shared) == 2L, length(survival_only) == 2L)
growth <- growth %>% mutate(from=cut(size_cm2,SIZE_BREAKS,labels=SIZE_LABELS,
  include.lowest=TRUE), to=cut(pmax(size_cm2+growth_metric,.1),SIZE_BREAKS,
  labels=SIZE_LABELS,include.lowest=TRUE)) %>% filter(!is.na(from),!is.na(to))
growth <- filter(growth,abs(growth_metric)<quantile(abs(growth_metric),.99,na.rm=TRUE))
cache <- setNames(lapply(grow_studies,function(st) {
  d <- filter(growth,study==st)
  ids <- unique(d$coral_id)
  stopifnot(!anyNA(ids))
  list(data=d,ids=ids,rows=lapply(ids,function(id) which(d$coral_id==id)))
}),grow_studies)
frag <- read_csv("05_data/standardized/apal_fragmentation.csv",show_col_types=FALSE)
fcols <- c("F4_SC1","F4_SC2","F4_SC3","F5_SC1","F5_SC2","F5_SC3","F5_SC4","F5_SC5")
frag <- frag %>% mutate(time_interval_yr=coalesce(time_interval_yr,1),
  across(all_of(fcols),~.x/time_interval_yr))
fragment_matrix <- function(d) {
  f <- matrix(0,5,5,dimnames=list(SIZE_LABELS,SIZE_LABELS))
  for (key in fcols) f[as.integer(substr(key,6,6)),as.integer(substr(key,2,2))] <- mean(d[[key]],na.rm=TRUE)
  f
}
stopifnot(max(abs(fragment_matrix(frag)-model$fragmentation))<1e-10)
donors <- readRDS(file.path(out,"survival_bootstrap_by_sc.rds"))
donors <- donors[apply(donors,1,function(x) all(is.finite(x))),,drop=FALSE]
stopifnot(nrow(donors)>1000L)
draw_growth <- function(studies) {
  d <- bind_rows(lapply(studies,function(st) {
    c <- cache[[st]]
    ids <- sample(c$ids,replace=TRUE)
    c$data[unlist(c$rows[match(ids,c$ids)],use.names=FALSE),]
  }))
  counts <- table(factor(d$to,levels=SIZE_LABELS),factor(d$from,levels=SIZE_LABELS))
  g <- sweep(counts,2,colSums(counts),"/"); g[is.nan(g)] <- 0
  g
}
eig <- function(a) Re(eigen(a,only.values=TRUE)$values[1])
draws <- list()
for (mode in c("unstratified_independent","stratified_independent","stratified_coordinated")) {
  set.seed(20261007) # same survival draws conditional on RNG stream; not claimed paired
  cat("Running",mode,"\n")
  records <- vector("list",n_boot)
  for (b in seq_len(n_boot)) {
    common_draw <- sample(shared,replace=TRUE)
    sd <- if (mode=="unstratified_independent") sample(surv_studies,replace=TRUE) else
      c(common_draw,sample(survival_only,replace=TRUE))
    gd <- if (mode=="stratified_coordinated") common_draw else sample(shared,replace=TRUE)
    scells <- bind_rows(lapply(seq_along(sd),function(i) {
      d <- filter(cells,study==sd[i]); d <- d[sample(nrow(d),replace=TRUE),]
      d$study <- paste0(sd[i],"_",i); d
    }))
    missing <- setdiff(SIZE_LABELS,as.character(scells$size_class))
    ss <- pool_survival(scells,fallback=s)
    gg <- draw_growth(gd)
    ff <- fragment_matrix(frag[sample(nrow(frag),replace=TRUE),])
    dd <- ss
    if (length(missing)) dd[missing] <- donors[sample(nrow(donors),1),missing]
    records[[b]] <- data.frame(mode=mode,iteration=b,n_missing=length(missing),
      missing_classes=paste(missing,collapse=","),lambda_point_impute=eig(gg%*%diag(ss)+ff),
      lambda_donor_impute=eig(gg%*%diag(dd)+ff))
    if (b%%500L==0L) cat(" ",b,"of",n_boot,"\n")
  }
  draws[[mode]] <- bind_rows(records)
}
draws <- bind_rows(draws)
stopifnot(nrow(draws)==6000L,all(is.finite(draws$lambda_point_impute)),
  all(is.finite(draws$lambda_donor_impute)))
write_csv(draws,file.path(out,"matrix_resampling_draws.csv"))
summarize <- function(x,label,n_imputed) data.frame(approach=label,n=length(x),
  n_imputed=n_imputed,mean=mean(x),ci_lower=quantile(x,.025),ci_upper=quantile(x,.975),
  fraction_below_one=mean(x<1))
primary <- readRDS(file.path(out,"lambda_bootstrap_comparison.rds"))
summary <- bind_rows(
  summarize(primary$lambda_boot_imputed,"primary_independent_point_impute",primary$n_imputed),
  summarize(primary$lambda_boot_discard,"primary_independent_discard",0),
  lapply(unique(draws$mode),function(mode) {
    d <- filter(draws,.data$mode==.env$mode)
    bind_rows(summarize(d$lambda_point_impute,paste0(mode,"_point_impute"),sum(d$n_missing>0)),
      summarize(d$lambda_donor_impute,paste0(mode,"_donor_impute"),sum(d$n_missing>0)))
  }))
write_csv(summary,file.path(out,"matrix_resampling_summary.csv"))
# Separate survival and fragmentation removal; G is unchanged because Vardi
# contributes no paired colony growth records to this matrix.
sv <- pool_survival(filter(cells,study!="vardi_2011"),fallback=s)
decomp <- data.frame(scenario=c("full_data","remove_vardi_survival_only",
  "remove_vardi_fragmentation_only","remove_both"),
  lambda=c(eig(a),eig(g%*%diag(sv)+model$fragmentation),
    eig(g%*%diag(s)),eig(g%*%diag(sv))))
decomp$change_from_full <- decomp$lambda-eig(a)
write_csv(decomp,file.path(out,"vardi_component_sensitivity.csv"))
print(summary); print(decomp)
