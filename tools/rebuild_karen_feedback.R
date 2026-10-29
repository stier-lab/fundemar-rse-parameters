#!/usr/bin/env Rscript
# Rebuild source corrections through the maintained manuscript consumers.
# Raw workbooks are read-only. Experimental models 41--47 are not paper results.
scripts <- c(
  "02_survival_thresholds.R", "03_growth_thresholds.R",
  "04_growth_rate_comparison.R", "05_variance_partitioning.R",
  "06_data_gap_analysis.R", "07_integrate_summary_data.R",
  "09_power_analysis.R", "10_cross_validation.R", "11_context_comparison.R",
  "12_model_selection.R", "13_transition_matrix.R", "14_meta_analysis.R",
  "14b_expanded_meta_analysis.R", "15_heterogeneity_analysis.R",
  "16_sensitivity_analysis.R", "17_update_parameter_lists.R",
  "18_fig1_study_landscape.R", "19_fig2_demographic_rates.R",
  "20_fig_size_class_survival_synthesis.R", "20b_fig_expanded_forest_plot.R",
  "20c_fig_regional_survival.R", "21_fig3_natural_vs_restoration.R",
  "22_fig6_population_model.R", "24_supp_S3_S4.R",
  "25_supp_S5_S6_S7_thresholds_growth.R", "26_supp_S8_S9.R",
  "28_supp_S12_S13_S14.R", "29_natural_vs_restoration.R",
  "30_disturbance_sensitivity.R", "32_disturbance_survival_analysis.R",
  "34_disturbance_summaries.R", "36_shrinkage_retrogression_summary.R",
  "37_disturbance_size_interaction.R", "37b_disturbance_type_size_interaction.R",
  "37c_rse_size_multipliers.R", "38_study_window_disturbance_audit.R",
  "39_restoration_subtype_sensitivity.R", "40_manzello_heatwave_scenarios.R",
  "49_matrix_concordance.R", "50_matrix_robustness.R",
  "51_heatwave_matrix_robustness.R", "49_annual_survival_timeseries.R",
  "49b_temporal_synthesis_figure.R", "50_derive_outplant_age.R",
  "52_colony_lesion_state.R", "53_sexual_fecundity_layer.R",
  "54_sterility_lag_layer.R", "55_lesion_fecundity_penalty.R",
  "56_outplant_age_model.R", "57_winter_sst_survival_model.R",
  "58_depensatory_corallivory_layer.R", "59_microhabitat_depth_model.R",
  "59b_fertilization_allee_layer.R", "60_scenario_comparison.R",
  "61_fig_biological_realism.R", "23_verification.R", "48_pipeline_refresh_audit.R")
args <- commandArgs(trailingOnly = TRUE)
if (length(args)) {
  index <- match(args[1], scripts)
  if (is.na(index)) stop("Unknown resume script")
  scripts <- scripts[seq.int(index, length(scripts))]
}
logdir <- "temp/karen_integration_2026-10-21/logs"
dir.create(logdir, recursive = TRUE, showWarnings = FALSE)
manifest <- "06_analysis/output/karen_feedback_rebuild_manifest.csv"
records <- if (length(args) && file.exists(manifest)) read.csv(manifest) else data.frame()
for (script in scripts) {
  message("START ", script)
  started <- Sys.time()
  log <- file.path(logdir, paste0(script, ".log"))
  status <- system2(file.path(R.home("bin"), "Rscript"),
    file.path("06_analysis/scripts", script), stdout = log, stderr = log)
  records <- rbind(records, data.frame(script, status,
    seconds = as.numeric(difftime(Sys.time(), started, units = "secs"))))
  write.csv(records, manifest, row.names = FALSE)
  if (status != 0L) stop(script, " failed: ", log)
  message("DONE ", script)
}
