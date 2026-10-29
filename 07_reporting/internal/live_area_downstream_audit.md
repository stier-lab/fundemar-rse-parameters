# Live-area matrix: independent downstream dependency audit

Audit date: 2026-10-19. Read-only source audit, except this report. No analysis, data, manuscript, or neighboring-repository files were edited by this auditor. Existing dirty files were preserved. The main agent owns the implementation and numerical rerun.

## Authorized documentation follow-up

After the read-only audit, the main agent assigned this auditor a separate documentation-only refresh using verified corrected outputs: lambda 0.940702161376; bootstrap interval 0.891561341–0.982442237; fraction below one 99.75% (99.8% at one decimal); SC5 stasis elasticity 54.1411% (interval 39.20669–68.21734%); no-fragmentation lambda 0.88092455; matched LOO range 0.8770317–0.9559685. The primary panel contains 4,301 records. Current elasticity CSV was also inspected directly to update aggregated size-class survival elasticities (SC1–SC5: 0.001329, 0.025212, 0.120170, 0.241366, 0.561623) and SC5 fragmentation elasticity (0.044277).

Refreshed files: `README.md`; `ORIENTATION.md`; `CLAUDE.md`; `06_analysis/output/README.md`; `06_analysis/scripts/README.md`; `parameter_lists/RSE_COMPATIBILITY.md`; `07_reporting/manuscript/rse_methods_one_pager.md`; `07_reporting/internal/transferability_summary.md`; `07_reporting/internal/claim_output_crosswalk.md`; `07_reporting/manuscript/figure_legends.txt`; `07_reporting/manuscript/tables/size_class_synthesis_table.md`; `05_data/integration/APAL_Collaborator_Guide.Rmd`; `05_data/integration/Elasticity_Analysis_Walkthrough.Rmd`.

Current documentation now states strict positive observed live endpoints, annualized change over one year, the 0.1-cm² projected endpoint floor, distinct RSE-export eligibility, and the boundary that the neighboring RSE analyses/app were not rerun. Old heatwave/scenario numerical claims were replaced with canonical output pointers while those producer scripts rerun; no unverified fresh scenario values were invented. The historical April compatibility change log remains labeled historical, and old tutorials carry prominent superseded notices rather than blanket number replacements. The companion RSE methods draft is explicitly marked unverified beyond the documented correction. Canonical main manuscript, ESM, code, and numerical outputs were not edited by this auditor. `git diff --check` passed after the documentation changes.

## Findings that require implementation, not merely a rerun

1. **Script 16 contains its own mixed-area matrix constructor.** `06_analysis/scripts/16_sensitivity_analysis.R` defines `compute_lambda_from_survival()` at line 58 and calculates `final_size = size_cm2 + growth_cm2_yr` at line 73. This shadows the similarly named shared helper. Fixing `utils/03_matrix_functions.R` therefore does not fix its boundary, outlier, interval-length, or exploratory individual-record LOO calculations. The script later sources script 49 to replace only the manuscript-facing LOO output. Verify every maintained exploratory sensitivity is either repaired and regenerated or explicitly retired, rather than left presenting the old endpoint convention.

2. **RSE parameter exports independently use total growth.** `06_analysis/scripts/17_update_parameter_lists.R` assigns `growth_rate = growth_cm2_yr` for field growth (line 517) and again for nursery growth (line 770). Its `bootstrap_growth_transitions()` adds `growth_rate` to `size_cm2` (line 337). Both exports need harmonized live-area growth before regeneration. The field export currently uses all natural-colony prepared records rather than the matrix's near-annual, metric-specific trimmed subset; decide and document whether the exported transition distribution is meant to reproduce the matrix exactly. Do not claim that the same endpoint alone makes the filters or estimators identical. Nursery scope is different and must retain its own documented eligibility rather than blindly inheriting natural-colony restrictions. Its growth mean helper's default is also named `growth_cm2_yr` (line 264), although maintained calls explicitly pass `growth_rate`.

3. **Scenario recomputation has a misleading raw-growth branch.** Script 60 reads `05_data/standardized/apal_growth_ind.csv` and filters `growth_cm2_yr`, including a total-growth q99 trim. However, all scenario calls in its `run_scenario()` use `G_override = tm$growth_transitions`; the current scenario matrices therefore inherit the canonical saved G rather than this raw branch. Replace the misleading total-area preparation with the canonical prepared-live contract or remove the unused dependence. S0 must reproduce the newly rebuilt matrix, not an old numerical target. Script 59b also explicitly uses saved G and should reproduce the new baseline after rerun.

4. **Shrinkage subset and transition subset are not exactly identical.** Script 36's `growth_matrix_compatible` restricts natural colonies, non-impossible growth, and 0.5–1.5-year intervals but does not apply script 13's metric-specific 99th-percentile trim. Its tissue-loss proportion and n therefore describe a near-annual growth panel, whereas its retrogression rows come from `transition_sample_sizes.csv`. Align the exact subsets if they are to share a matrix-compatible claim, or explicitly distinguish them. Merely rerunning 36 changes matrix-derived parts but does not remove this distinction.

5. **Do not preserve historical baselines as executable targets.** `CLAUDE.md` line 266, `parameter_lists/RSE_COMPATIBILITY.md`, and `07_reporting/manuscript/rse_methods_one_pager.md` describe 0.9613 as a published baseline and attribute CSV/G discrepancies to data accretion or precision anchoring. These are current workflow/interface instructions, not a safe historical record. They need an explicit corrected-live-area baseline and rationale. The old mixed-area estimator must not be restored just to satisfy those statements.

## Dependency and rebuild order

| Stage | Producers / inputs | Maintained consumers / action |
|---|---|---|
| Core matrix | `13_transition_matrix.R`, prepared live-area growth, survival cells, fragmentation | Rebuild all script-13 outputs, not just eigenvalue or CSV matrix. |
| Independent reconstruction | `49_matrix_concordance.R` | Rebuild matched-estimator LOO and assert reconstruction equals saved A and lambda. |
| Matrix uncertainty sensitivity | `50_matrix_robustness.R`, saved bootstrap distributions | Rebuild resampling draws/summary and Vardi component decomposition. |
| Other sensitivities | `16_sensitivity_analysis.R` after repairing its local constructor | Regenerate boundary/outlier/interval/bootstrap-failure/fragmentation diagnostics; it invokes 49 for manuscript LOO. |
| RSE interface | repaired `17_update_parameter_lists.R` after 13 | Regenerate field/nursery growth and survival parameter bundles, recruit/lab bundles as appropriate; retain public bundle schemas and annotate endpoint/filter provenance. |
| Main display | `22_fig6_population_model.R` | `Fig4_population_model.png/.pdf`, using saved matrix, elasticities, bootstrap draws, LOO. |
| Additional matrix displays | `28_supp_S12_S13_S14.R` after 16 and 13 | Regenerate FigS12 sensitivity and FigS14 population projections (FigS13 is emitted in same script but its CV inputs do not depend on this correction). |
| Shrinkage/retrogression | `36_shrinkage_retrogression_summary.R` after 13 | Regenerate matrix-derived transition summaries and FigS16; resolve subset wording above. This is ESM Fig. S3. |
| Primary heatwaves | `40_manzello_heatwave_scenarios.R` after 13 | Heatwave scenario summary/projections, FigS22 (ESM Fig. S6). Recompute baseline and all return intervals. |
| Full-matrix heatwaves | `51_heatwave_matrix_robustness.R` after 13 and 40 | Full-matrix/lambda-only projections and summary; feeds ESM Table S4. It already asserts saved lambdas equal complete bootstrap-matrix lambdas. |
| Temporal display | `49b_temporal_synthesis_figure.R` after 40 | FigS28 panel c reads heatwave summary; IPM/regime panels are independent and need no model refit for this correction. |
| Scenario component caches | `56_outplant_age_model.R`, `57_winter_sst_survival_model.R`, `58_depensatory_corallivory_layer.R`, `59_microhabitat_depth_model.R`, `59b_fertilization_allee_layer.R` | All read saved baseline S or G; regenerate before 60 so metadata/baseline-derived quantities cannot remain stale, even though S itself should be unchanged. 59b requires existing sexual-fecundity object from 53. |
| Biological realism | `60_scenario_comparison.R` after component caches and canonical G | `biological_realism_scenarios.csv/.rds`, `parameter_lists/scenario_matrices.rds`; assert S0 A and lambda match canonical baseline. |
| Scenario display | `61_fig_biological_realism.R` after 60 | FigS29 and its trajectories; note plot chooses S0–S8, existing scenario-set issue is separate from this correction. |
| Canonical stats | `23_verification.R` then `48_pipeline_refresh_audit.R` | Refresh `canonical_statistics.csv`, generated markdown registries/reports, freshness metadata after numerical outputs and figures. |
| Manuscript and Word | source prose/tables/legends updated from regenerated CSV/RDS | `paper/scripts/assemble_manuscript.sh` blocks stale model reporting before main Word assembly; run main and supplement render pipelines and inspect final Word-derived PDFs. |

Scripts 53–55 depend on recruit/survival inputs or lesion state, not the corrected matrix-growth block directly. If 17 changes only growth exports and identical survival/recruit exports, these fitted layers do not require numerical refits, but the 56–60 baseline-dependent caches still require verification. Full maintained pipeline order includes all of these; a matrix-only make target does not.

## Script-13 outputs whose downstream consistency must be checked

`population_stable_distribution.csv`; `transition_sample_sizes.csv`; `transition_matrix.csv/.rds`; `population_parameters.csv`; `transition_matrix_bootstrap_ci.csv`; `lambda_bootstrap_diagnostics.csv`; `lambda_bootstrap_samples.rds`; `lambda_bootstrap_comparison.rds`; `transition_bootstrap_matrices.rds`; `survival_bootstrap_by_sc.rds`; `transition_matrix_imputation_sensitivity.csv`; `bootstrap_failure_analysis.csv`; `elasticity_bootstrap_ci.csv`; `elasticity_matrix.csv`; `vital_rate_elasticity.csv`; `stochastic_projections.csv`; `stochastic_lambda_estimate.csv`; `fragmentation_sensitivity.csv`; `fragmentation_scenarios.csv`; `fecundity_sensitivity.csv`; `mortality_definition_sensitivity.csv`; `transition_matrix_model_diagnostics.csv`; `transition_matrix_source_leverage.csv`.

Not every value must change. Survival, fragmentation inputs, source counts, and support proportions should remain identical unless the audit discovers and explicitly documents an additional correction. Growth-transition support n may change under live-specific trimming. New bootstrap draws can change missing-class imputation counts if random-number consumption changes; do not carry the old count forward by assumption.

## Current public and maintained prose that needs refresh

- `07_reporting/manuscript/acropora_palmata_demography_manuscript_draft.md`: abstract; all matrix/elasticity/LOO/fragmentation claims; resampling sensitivity; heatwave baseline and observed endpoint rates; full-matrix sensitivity; any interpretation relying on the magnitude of the correction.
- `paper/submission/supplement/ESM_1.md`: matrix methods; ESM Fig. S3/S6 captions; Table S3 all six resampling rows; Vardi component and elasticity narrative; Table S4 all eight initial-composition/method rows; all matched prose. Do not assume year-50 proportions remain 100%.
- `07_reporting/manuscript/claims.tsv`: cl6 literal source anchor currently reads `deterministic lambda of 0.959`; must track updated wording or the claim gate fails even when prose is numerically right.
- `07_reporting/manuscript/figure_legends.txt`: canonical figure list still contains legacy 0.961, SC5 survival elasticity 60.2%, and S0 0.9613. Update the affected figure legends; distinguish cell elasticity from aggregated survival elasticity.
- `07_reporting/manuscript/tables/size_class_synthesis_table.md`: inspect for matrix-rate/elasticity cells; retain unchanged demographic results rather than blanket replacing coincident numbers.
- `README.md`: status paragraph and summary/caveat tables (old 0.959, interval 0.902–1.001, bootstrap share 97.1%, SC5 cell elasticity 59.8%).
- `ORIENTATION.md`: old 0.9613 and associated quasi-extinction headlines.
- `06_analysis/output/README.md`: current key finding and biological-scenario baseline descriptions (old 0.961 and 0.9613).
- `06_analysis/scripts/README.md`: current headline numerical table (old 0.961).
- `parameter_lists/RSE_COMPATIBILITY.md`, `07_reporting/manuscript/rse_methods_one_pager.md`, `CLAUDE.md`: fix current external-interface/runner instructions as above; these are not proof that neighboring RSE code itself was updated.
- `07_reporting/internal/transferability_summary.md` and `07_reporting/internal/claim_output_crosswalk.md`: maintained interpretation notes should reflect new values or point to output-backed canonical statistics.
- `paper/manuscript/combined_manuscript.md` and `_word.md` are generated artifacts; rebuild rather than independently edit.
- `05_data/integration/APAL_Collaborator_Guide.Rmd` and `Elasticity_Analysis_Walkthrough.Rmd` contain much older 0.986 headline claims and decline-probability language. They are non-pipeline tutorials but potentially public and not self-evidently archived; either update and render or add a conspicuous historical/outdated notice rather than imply they describe the new baseline.

## Historical records to preserve rather than globally replace

`07_reporting/internal/aldo_comments_2026-10-19.md`, `jameal_comments_2026-10-19.md`, `matrix_live_area_audit_2026-10-19.md`, `generated/matrix_robustness_validation_2026-10-07.md`, dated prose-audit files, `04_extraction/data_integration_issues.md`, `docs/CONCORDANCE_AUDIT.md`, `01_protocol/PRISMA_checklist.md`, and `07_reporting/internal/biological_realism_PRD.md` contain historical values/diagnostic estimates. Preserve factual old outcomes; add an explicit superseded/current-output pointer if needed. Do not replace the diagnostic 0.938957 with a final value as though that had been the result originally observed. Dated pipeline logs/context CSVs are historical, not outputs to rewrite.

## Secondary copies / boundaries

- Dark slide scripts (`22_fig6_population_model_DARK.R`, `28_supp_S12_S13_S14_DARK.R`, `28_figS14_population_projections_DARK.R`, `36_shrinkage_retrogression_summary_DARK.R`, `40_manzello_heatwave_scenarios_DARK.R`, `49b_temporal_synthesis_figure_DARK.R`, `61_fig_biological_realism_DARK.R`) are outside `run_all.R`. They read the same downstream outputs but must be run separately if maintained slide images are part of the deliverable. **Do not source them indiscriminately:** some copied analysis scripts write data output as well as dark figures. Verify output destinations first; `DARK_OUT_PNG` is required by the documented style-only templates.
- No neighboring RSE repo was edited. Updated `parameter_lists` exports and corrected compatibility documentation do not mean the sibling RSE analyses or manuscript were rerun. State that boundary explicitly.
- Advanced independent models (41–47) do not consume the canonical five-class matrix; their outputs should not be relabeled or refit solely because G in this model changes. Likewise the survival meta-analysis and its forest plots do not change solely because live-area transitions are corrected.

## Required numerical and rendering gates

1. `49_matrix_concordance.R`: saved A equals independent live-area reconstruction; eigenvalue equals saved lambda; LOO source removal uses the same endpoint and filters.
2. Complete bootstrap matrices have the same eigenvalues and order as `lambda_bootstrap_samples.rds`; `51_heatwave_matrix_robustness.R` already tests this.
3. Scenario S0 and exported `parameter_lists/scenario_matrices.rds$S0` reproduce corrected A and lambda; field/nursery growth transition rows sum to one, finite values and supported class labels retained.
4. Run `make submit-check` with the pinned R installation, plus main/supplement citation checks and Word compatibility preflight. Existing `tools/check_matrix_reporting.py` and `check_robustness_reporting.py` are output-derived, not old-value tests; they should pass after correct prose refresh without changing their comparisons to force agreement.
5. Visually inspect rebuilt Fig. 4, ESM Fig. S3/S6, supplementary sensitivity/projection/scenario figures, and all final main/supplement PDF pages generated from Word. Check render length/captions and no old embedded image remains.

## Clean negative findings

- Canonical manuscript assembly already blocks stale matrix and robustness prose; it does not silently overwrite new prose from old combined files.
- Primary heatwave and full-matrix robustness scripts read the saved canonical matrix/bootstrap outputs, not a separate hard-coded 0.959 matrix.
- Script 60 and 59b explicitly use saved G, so their numerical baseline should propagate on rerun; stale numerical baseline comments are not themselves a separate active G estimator.
- No change to sexual recruitment is justified by this area correction. The canonical subsystem remains recruitment-free apart from its existing fragmentation block.
