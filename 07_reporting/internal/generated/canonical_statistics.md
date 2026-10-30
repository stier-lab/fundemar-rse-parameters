# Canonical Statistics

Generated from pipeline run `20261030_131553` on 2026-10-30 14:03:26.

## Disturbance

| Metric | Value | Source |
|---|---|---|
| `baseline_exclusion_intervals` | 289 | `06_analysis/output/study_window_disturbance_summary_overall.csv` |
| `baseline_exclusion_pooled_survival_pct` | 72.3% | `06_analysis/output/disturbance_sensitivity_summary.csv` |
| `disturbance_size_interaction_lrt_p` | p = 0.004189 | `06_analysis/output/disturbance_size_survival_model.csv` |
| `study_window_intervals` | 1003 | `06_analysis/output/study_window_disturbance_summary_overall.csv` |
| `study_window_intervals_audited` | 1003 | `06_analysis/output/study_window_disturbance_summary_overall.csv` |
| `study_window_pct_any_overlap` | 96.5% | `06_analysis/output/study_window_disturbance_summary_overall.csv` |

## Growth

| Metric | Value | Source |
|---|---|---|
| `agr_r2_pct` | 3.1% | `06_analysis/output/growth_rate_summary.csv` |
| `rgr_allometry_inflection_cm2` | 853.0 cm² | `06_analysis/output/growth_rate_summary.csv` |
| `rgr_r2_pct` | 17.6% | `06_analysis/output/growth_rate_summary.csv` |
| `rgr_vs_agr_improvement_x` | 6x | `06_analysis/output/growth_rate_summary.csv` |

## Meta Analysis

| Metric | Value | Source |
|---|---|---|
| `i_squared_pct` | 97.6% | `06_analysis/output/expanded_meta_analysis_results.csv` |
| `k_studies` | 17 | `06_analysis/output/expanded_meta_analysis_results.csv` |
| `n_effects` | 22 | `06_analysis/output/expanded_meta_analysis_results.csv` |
| `n_observations` | 9042 | `06_analysis/output/expanded_meta_analysis_results.csv` |
| `pooled_ci_lower_pct` | 70.7% | `06_analysis/output/expanded_meta_analysis_results.csv` |
| `pooled_ci_upper_pct` | 85.2% | `06_analysis/output/expanded_meta_analysis_results.csv` |
| `pooled_survival_pct` | 78.9% | `06_analysis/output/expanded_meta_analysis_results.csv` |
| `prediction_interval_lower_pct` | 38.0% | `06_analysis/output/expanded_meta_analysis_results.csv` |
| `prediction_interval_upper_pct` | 95.8% | `06_analysis/output/expanded_meta_analysis_results.csv` |
| `tau_squared` | 0.7118 | `06_analysis/output/expanded_meta_analysis_results.csv` |

## Population

| Metric | Value | Source |
|---|---|---|
| `annual_decline_pct_from_bootstrap_mean` | 4.49% | `06_analysis/output/lambda_bootstrap_samples.rds` |
| `lambda_bootstrap_mean` | 0.9551 | `06_analysis/output/lambda_bootstrap_samples.rds` |
| `lambda_ci_lower` | 0.913 | `06_analysis/output/population_parameters.csv` |
| `lambda_ci_upper` | 1.000 | `06_analysis/output/population_parameters.csv` |
| `lambda_deterministic` | 0.953 | `06_analysis/output/population_parameters.csv` |
| `max_elasticity_pct` | 51.5% | `06_analysis/output/elasticity_matrix.csv` |
| `p_decline_pct` | 97.4% | `06_analysis/output/population_parameters.csv` |

## Restoration

| Metric | Value | Source |
|---|---|---|
| `all_restoration_subtypes_mean_survival_pct` | 61.8% | `06_analysis/output/restoration_subtype_sensitivity.csv` |
| `all_subtypes_mean_survival_pct` | 61.8% | `06_analysis/output/restoration_subtype_sensitivity.csv` |
| `endpoint_selected_fragments_n` | 94 | `06_analysis/output/restoration_subtype_survival_summary.csv` |
| `exclude_natural_mean_survival_pct` | 61.8% | `06_analysis/output/restoration_subtype_sensitivity.csv` |
| `nursery_only_mean_survival_pct` | 58.7% | `06_analysis/output/restoration_subtype_sensitivity.csv` |
| `subtype_survival_estimable_records` | 1163 | `06_analysis/output/restoration_subtype_survival_summary.csv` |
| `survival_natural_fragment` | Not estimable | `06_analysis/output/restoration_subtype_survival_summary.csv` |
| `survival_nursery_fragment` | 86.4% | `06_analysis/output/restoration_subtype_survival_summary.csv` |
| `survival_nursery_outplant` | 57.4% | `06_analysis/output/restoration_subtype_survival_summary.csv` |
| `survival_nursery_outplant_recemented` | 81.1% | `06_analysis/output/restoration_subtype_survival_summary.csv` |
| `survival_outplanted_colony` | 65.2% | `06_analysis/output/restoration_subtype_survival_summary.csv` |
| `survival_sexual_recruit_nursery` | 100.0% | `06_analysis/output/restoration_subtype_survival_summary.csv` |
| `survival_sexual_recruit_outplant` | 100.0% | `06_analysis/output/restoration_subtype_survival_summary.csv` |

## Shrinkage

| Metric | Value | Source |
|---|---|---|
| `matrix_compatible_shrinkage_frequency_pct` | 39.5% | `06_analysis/output/shrinkage_retrogression_subset_summary.csv` |
| `matrix_compatible_shrinkage_pct` | 39.5% | `06_analysis/output/shrinkage_retrogression_subset_summary.csv` |

## Survival

| Metric | Value | Source |
|---|---|---|
| `gam_deviance_explained_pct` | 8.9% | `06_analysis/output/prepared_survival_data.rds` |
| `glm_p_value` | p < 0.001 | `06_analysis/output/prepared_survival_data.rds` |
| `n_observations_natural` | 6500 | `06_analysis/output/prepared_survival_data.rds` |
| `n_studies_natural` | 2 | `06_analysis/output/prepared_survival_data.rds` |
| `odds_ratio_ci_lower` | 1.400 | `06_analysis/output/prepared_survival_data.rds` |
| `odds_ratio_ci_upper` | 1.496 | `06_analysis/output/prepared_survival_data.rds` |
| `odds_ratio_log_size` | 1.447 | `06_analysis/output/prepared_survival_data.rds` |
| `tjur_r2_pct` | 8.3% | `06_analysis/output/prepared_survival_data.rds` |

## Thresholds

| Metric | Value | Source |
|---|---|---|
| `absolute_growth_threshold_cm2` | 6678 cm² | `06_analysis/output/growth_thresholds.csv` |
| `positive_growth_prob_threshold_cm2` | NA cm² | `06_analysis/output/growth_thresholds.csv` |
| `relative_growth_rate_threshold_cm2` | 35 cm² | `06_analysis/output/growth_thresholds.csv` |
| `survival_threshold_cm2` | 7497.7 cm² | `06_analysis/output/survival_thresholds.csv` |

