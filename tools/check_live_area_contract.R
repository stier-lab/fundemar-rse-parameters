#!/usr/bin/env Rscript
# Fail-closed input and source-to-result gate for live-area transitions.
suppressPackageStartupMessages({library(dplyr); library(tidyr); library(readr)})
source("06_analysis/scripts/utils/shared_utilities.R")
out <- "06_analysis/output"
raw <- readRDS(file.path(out, "prepared_growth_data.rds"))
live <- prepare_live_area_growth(raw)
stopifnot(all(is.finite(live$size_live_cm2)), all(is.finite(live$growth_live_cm2_yr)),
  all(live$size_cm2 == live$size_live_cm2),
  all(live$growth_metric == live$growth_live_cm2_yr))
# A missing live endpoint cannot be silently replaced by large skeletal growth.
toy <- raw[1:3, ]
toy$size_live_cm2 <- c(20, NA, 20)
toy$growth_live_cm2_yr <- c(-5, 100, NA)
toy$growth_cm2_yr <- c(500, 500, 500)
toy$time_interval_yr <- 1
checked <- prepare_live_area_growth(toy)
stopifnot(nrow(checked) == 1L, checked$size_cm2 == 20, checked$growth_metric == -5)
# A death remains in survival data but cannot be a survivor growth transition.
toy <- raw[1, ]
toy$size_live_cm2 <- 20
toy$growth_live_cm2_yr <- -20
toy$time_interval_yr <- 1
stopifnot(nrow(prepare_live_area_growth(toy)) == 0L)
d <- live %>% filter(population_type == "Natural colony", !impossible_growth,
  time_interval_yr >= .5, time_interval_yr <= 1.5) %>%
  mutate(from = cut(size_live_cm2, SIZE_BREAKS, labels = SIZE_LABELS, include.lowest = TRUE),
         to = cut(pmax(size_live_cm2 + growth_live_cm2_yr, .1), SIZE_BREAKS,
                  labels = SIZE_LABELS, include.lowest = TRUE)) %>%
  filter(!is.na(from), !is.na(to))
d <- filter(d, abs(growth_live_cm2_yr) < quantile(abs(growth_live_cm2_yr), .99))
counts <- table(factor(d$to, levels = SIZE_LABELS), factor(d$from, levels = SIZE_LABELS))
g <- sweep(counts, 2, colSums(counts), "/")
stopifnot(all(is.finite(g)), all(g >= 0), max(abs(colSums(g) - 1)) < 1e-12)
model <- readRDS(file.path(out, "transition_matrix.rds"))
stopifnot(max(abs(g - model$growth_transitions)) < 1e-12)
a <- g %*% diag(model$survival_rates) + model$fragmentation
stopifnot(max(abs(a - model$projection_matrix)) < 1e-12,
  abs(Re(eigen(a)$values[1]) - model$lambda) < 1e-12)
boot <- readRDS(file.path(out, "transition_bootstrap_matrices.rds"))
boot_lam <- vapply(boot$matrices, function(x) Re(eigen(x, only.values = TRUE)$values[1]), numeric(1))
stopifnot(length(boot_lam) == 2000L, max(abs(boot_lam - boot$lambda)) < 1e-10,
  max(abs(boot$lambda - readRDS(file.path(out, "lambda_bootstrap_samples.rds")))) < 1e-10)
# Interface bundles retain their wider field/nursery eligibility, but every
# growth draw uses live area and is a finite probability distribution.
for (file in c("field_growth_pars.rds", "nurs_growth_pars.rds")) {
  bundle <- readRDS(file.path("parameter_lists", file))
  stopifnot(identical(bundle$growth_measure, "live_planar_area_survivor"))
  for (draws in bundle$mat_list) {
    draws <- as.matrix(draws)
    stopifnot(all(is.finite(draws)), all(draws >= 0),
              max(abs(rowSums(draws) - 1)) < 1e-10)
  }
}
scenarios <- readRDS("parameter_lists/scenario_matrices.rds")
stopifnot(abs(scenarios$S0$lambda - model$lambda) < 1e-10,
          max(abs(scenarios$S0$matrix - model$projection_matrix)) < 1e-10)
cat(sprintf("PASS - strict live-area contract: %d growth records; lambda %.12f; %d bootstrap matrices.\n",
  nrow(d), model$lambda, length(boot_lam)))
