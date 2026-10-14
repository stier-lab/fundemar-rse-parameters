#!/usr/bin/env Rscript
# Reconstruct script 13's deterministic estimator and its study-exclusion checks.
# The full-data matrix must match before any derived outputs are written.
suppressPackageStartupMessages({library(dplyr); library(tidyr); library(readr)})
source("06_analysis/scripts/utils/shared_utilities.R")
out <- "06_analysis/output"
model <- readRDS(file.path(out, "transition_matrix.rds"))
cells <- readRDS(file.path(out, "prepared_survival_cells.rds")) %>%
  filter(population_type == "Natural colony", !is.na(size_class))
growth <- readRDS(file.path(out, "prepared_growth_data.rds")) %>%
  filter(population_type == "Natural colony", time_interval_yr >= .5,
         time_interval_yr <= 1.5)
if ("impossible_growth" %in% names(growth)) growth <- filter(growth, !impossible_growth)

pool_survival <- function(dat, fallback = NULL) {
  effects <- dat %>% mutate(annual_survival = prop_survived^(1/time_interval_yr)) %>%
    group_by(study, size_class) %>%
    summarise(n = sum(n_initial), survival = sum(n_initial * annual_survival)/n,
              .groups = "drop") %>%
    mutate(xi = pmax(1, pmin(n-1, round(survival*n))))
  s <- setNames(numeric(5), SIZE_LABELS)
  for (sc in SIZE_LABELS) {
    d <- filter(effects, size_class == sc)
    if (nrow(d) == 0) {
      if (is.null(fallback)) stop("Missing full-data survival class: ", sc)
      s[sc] <- fallback[sc]
    } else if (nrow(d) == 1) {
      s[sc] <- d$survival
    } else {
      es <- metafor::escalc(measure="PLO", xi=d$xi, ni=d$n, add=.5, to="only0")
      fit <- tryCatch(metafor::rma(yi=es$yi, vi=es$vi, method="REML", test="knha"),
        error=function(e) metafor::rma(yi=es$yi, vi=es$vi, method="FE", test="knha"))
      s[sc] <- predict(fit, transf=plogis)$pred
    }
  }
  s
}

growth_matrix <- function(dat) {
  dat <- dat %>% mutate(from = cut(size_cm2, SIZE_BREAKS, labels=SIZE_LABELS,
                                  include.lowest=TRUE),
    to = cut(pmax(size_cm2+growth_cm2_yr,.1), SIZE_BREAKS, labels=SIZE_LABELS,
             include.lowest=TRUE)) %>% filter(!is.na(from), !is.na(to))
  if (!nrow(dat)) stop("No growth records after study exclusion")
  dat <- filter(dat, abs(growth_cm2_yr) < quantile(abs(growth_cm2_yr), .99, na.rm=TRUE))
  counts <- table(factor(dat$to, levels=SIZE_LABELS), factor(dat$from, levels=SIZE_LABELS))
  g <- sweep(counts, 2, colSums(counts), "/")
  g[is.nan(g)] <- 0
  g
}

s <- pool_survival(cells)
g <- growth_matrix(growth)
a <- g %*% diag(s) + model$fragmentation
stopifnot(max(abs(a-model$projection_matrix)) < 1e-10)
lambda <- Re(eigen(a)$values[1])
stopifnot(abs(lambda-model$lambda) < 1e-10)
studies <- sort(unique(c(as.character(cells$study), as.character(growth$study))))
loo <- bind_rows(lapply(studies, function(study) {
  ss <- pool_survival(filter(cells, .data$study != .env$study), fallback=s)
  gg <- growth_matrix(filter(growth, .data$study != .env$study))
  # Vardi is the only fragment-production source; remove it in its exclusion.
  ff <- if (study == "vardi_2011") model$fragmentation * 0 else model$fragmentation
  data.frame(excluded_study=study, lambda=Re(eigen(gg %*% diag(ss)+ff)$values[1]))
}))
write_csv(loo, file.path(out,"sensitivity_lambda_loo.csv"))
params <- read_csv(file.path(out,"population_parameters.csv"),show_col_types=FALSE)
for (key in c("loso_lambda_min","loso_lambda_max","loso_lambda_range")) {
  val <- switch(key, loso_lambda_min=min(loo$lambda), loso_lambda_max=max(loo$lambda),
                loso_lambda_range=diff(range(loo$lambda)))
  params$value[params$parameter==key] <- val
  params$notes[params$parameter==key] <- "Matched script-13 estimator; script 49 study exclusion"
}
write_csv(params,file.path(out,"population_parameters.csv"))
cat(sprintf("PASS: reconstructed lambda %.12f matches saved matrix.\n",lambda))
print(loo)
