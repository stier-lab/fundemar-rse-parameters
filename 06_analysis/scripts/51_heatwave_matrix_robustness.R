#!/usr/bin/env Rscript
# Compare complete-matrix and lambda-only uncertainty using every valid draw.
suppressPackageStartupMessages({library(readr);library(dplyr)})
out <- "06_analysis/output"
model <- readRDS(file.path(out,"transition_matrix.rds"))
boot <- readRDS(file.path(out,"transition_bootstrap_matrices.rds"))
stopifnot(length(boot$matrices)==2000L,length(boot$lambda)==2000L)
stopifnot(max(abs(boot$lambda-readRDS(file.path(out,"lambda_bootstrap_samples.rds"))))<1e-10)
full <- simplify2array(boot$matrices)
scalar <- simplify2array(lapply(boot$lambda,function(l) model$projection_matrix*l/model$lambda))
stopifnot(all(full>=0),all(is.finite(full)))
scenarios <- read_csv(file.path(out,"heatwave_scenario_summary.csv"),show_col_types=FALSE)
starts <- list(original=c(100,50,30,20,10)/210,
  recruit_heavy=c(.7,.15,.08,.05,.02),adult_heavy=c(.02,.03,.05,.2,.7),
  stable=as.numeric(model$stable_distribution)/sum(model$stable_distribution))
methods <- list(lambda_only=scalar,full_matrix=full)
results <- list(); trajectories <- list()
for (i in seq_len(nrow(scenarios))) {
  scenario <- scenarios[i,]
  # Pair heatwave draws across starts/methods so differences reflect matrices
  # and initial structure, not different mortality draws.
  set.seed(20261007+i)
  ri <- scenario$return_interval_yr
  if (scenario$scenario=="baseline") ri <- 0
  event <- matrix(1,2000,50)
  for (year in seq_len(50)) if (ri>0 && year%%ri==0) {
    if (scenario$scenario=="observed_2023_florida") event[,year] <- runif(2000,0,.022)
    else event[,year] <- 1-scenario$heatwave_mortality
  }
  for (method in names(methods)) for (initial in names(starts)) {
    mat <- methods[[method]]
    pop <- matrix(rep(starts[[initial]],2000),5,2000)
    totals <- matrix(1,2000,51)
    for (year in seq_len(50)) {
      next_pop <- matrix(0,5,2000)
      for (to in seq_len(5)) next_pop[to,] <- colSums(mat[to,,]*pop)
      pop <- sweep(next_pop,2,event[,year],"*")
      totals[,year+1] <- colSums(pop)
    }
    # Endpoint-based finite-horizon growth includes zeros, unlike dropping
    # undefined ratios after extinction. No process noise is added to A.
    effective <- exp(mean(log(totals[,51]))/50)
    key <- paste(i,method,initial,sep="_")
    results[[key]] <- data.frame(scenario=scenario$scenario,return_interval_yr=ri,
      method=method,initial=initial,n=2000,effective_lambda=effective,
      p_below_10pct_year50=mean(totals[,51]<.1),
      p_ever_below_10pct=mean(apply(totals,1,min)<.1),
      year50_median_pct=median(totals[,51])*100)
    trajectories[[key]] <- data.frame(scenario=scenario$scenario,return_interval_yr=ri,
      method=method,initial=initial,year=0:50,median_pct=apply(totals,2,median)*100,
      lower_pct=apply(totals,2,quantile,.025)*100,
      upper_pct=apply(totals,2,quantile,.975)*100)
  }
}
summary <- bind_rows(results)
stopifnot(nrow(summary)==nrow(scenarios)*8L,all(is.finite(summary$effective_lambda)),
  all(summary$p_ever_below_10pct>=summary$p_below_10pct_year50))
write_csv(summary,file.path(out,"heatwave_matrix_robustness_summary.csv"))
write_csv(bind_rows(trajectories),file.path(out,"heatwave_matrix_robustness_projections.csv"))
print(as_tibble(filter(summary,scenario%in%c("baseline","observed_2023_florida"))),n=40)
