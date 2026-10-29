#!/usr/bin/env Rscript
# Rebuild every maintained consumer of the corrected live-area matrix.
# Does not refit unrelated survival meta-analysis, GAMs or advanced model families.
# Existing prepared data and biological-layer source inputs remain unchanged.
scripts <- c("13_transition_matrix.R", "16_sensitivity_analysis.R",
  "17_update_parameter_lists.R", "49_matrix_concordance.R", "50_matrix_robustness.R",
  "36_shrinkage_retrogression_summary.R", "40_manzello_heatwave_scenarios.R",
  "51_heatwave_matrix_robustness.R", "22_fig6_population_model.R",
  "28_supp_S12_S13_S14.R", "49b_temporal_synthesis_figure.R",
  "56_outplant_age_model.R", "57_winter_sst_survival_model.R",
  "58_depensatory_corallivory_layer.R", "59_microhabitat_depth_model.R",
  "59b_fertilization_allee_layer.R", "60_scenario_comparison.R",
  "61_fig_biological_realism.R", "23_verification.R", "48_pipeline_refresh_audit.R")
if ("--downstream-only" %in% commandArgs(trailingOnly = TRUE)) scripts <- scripts[-1]
dir.create("temp/live_area_rebuild_logs", recursive = TRUE, showWarnings = FALSE)
records <- list()
for (script in scripts) {
  message("START ", script)
  logfile <- file.path("temp/live_area_rebuild_logs", paste0(script, ".log"))
  start <- Sys.time()
  status <- system2(file.path(R.home("bin"), "Rscript"),
    file.path("06_analysis/scripts", script), stdout = logfile, stderr = logfile)
  records[[script]] <- data.frame(script = script, status = status,
    elapsed_seconds = as.numeric(difftime(Sys.time(), start, units = "secs")))
  write.csv(do.call(rbind, records), "06_analysis/output/live_area_rebuild_manifest.csv",
    row.names = FALSE)
  if (status != 0L) stop(script, " failed; inspect ", logfile)
  message("DONE ", script)
}
status <- system2(file.path(R.home("bin"), "Rscript"), "tools/check_live_area_contract.R")
if (status != 0L) stop("Live-area contract failed")
message("PASS - all maintained live-area downstream consumers rebuilt.")
