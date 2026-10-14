#!/usr/bin/env Rscript
# Compare an isolated, locked-environment rerun with manuscript-facing outputs.
args <- commandArgs(trailingOnly=TRUE)
if (length(args)!=1L) stop("Usage: Rscript tools/check_clean_matrix_rerun.R ISOLATED_REPO")
source("tools/check_r_version.R")
fresh <- file.path(args[1], "06_analysis/output")
current <- "06_analysis/output"
a <- readRDS(file.path(current,"transition_matrix.rds"))
b <- readRDS(file.path(fresh,"transition_matrix.rds"))
stopifnot(isTRUE(all.equal(a$projection_matrix,b$projection_matrix,tolerance=1e-12)),
          isTRUE(all.equal(a$lambda,b$lambda,tolerance=1e-12)),
          isTRUE(all.equal(a$stable_distribution,b$stable_distribution,tolerance=1e-12)))
x <- readRDS(file.path(current,"lambda_bootstrap_samples.rds"))
y <- readRDS(file.path(fresh,"lambda_bootstrap_samples.rds"))
stopifnot(length(x)==2000L,length(y)==2000L,identical(x,y))
ma <- readRDS(file.path(current,"transition_bootstrap_matrices.rds"))
mb <- readRDS(file.path(fresh,"transition_bootstrap_matrices.rds"))
stopifnot(length(ma$matrices)==2000L,length(mb$matrices)==2000L,
          isTRUE(all.equal(ma$matrices,mb$matrices,tolerance=1e-12)))
for (name in c("matrix_resampling_summary.csv","vardi_component_sensitivity.csv",
               "heatwave_matrix_robustness_summary.csv")) {
  stopifnot(isTRUE(all.equal(read.csv(file.path(current,name)),
                           read.csv(file.path(fresh,name)),tolerance=1e-12)))
}
cat(sprintf("PASS - isolated locked rerun: lambda %.12f; all 2,000 bootstrap draws identical; three sensitivity summaries match.\n",a$lambda))
cat(sprintf("Bootstrap interval %.12f–%.12f; fraction below one %.4f.\n",
            quantile(y,.025),quantile(y,.975),mean(y<1)))
