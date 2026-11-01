# Orientation — Detmer-2025-coral-parameters

_Last reviewed: 2026-11-01 · branch `codex-pipeline-refresh-automation`. Consult `git status` for the working-tree state; this repository intentionally tracks regenerated analysis outputs._

## What this is
PRISMA-structured systematic review + meta-analysis of **size-dependent demography in the Caribbean elkhorn coral *Acropora palmata***, targeting *Coral Reefs*. The synthesis includes 18 studies; the survival meta-analysis uses 17 studies and 22 effects across 13 Caribbean regions. Pooled annual survival is **0.789 (95% CI 0.708–0.853; PI 0.380–0.958)** under extreme heterogeneity (**I² = 97.6%**), from the interval-annualized three-level `rma.mv()`. The corrected recruitment-free transition matrix gives **λ = 0.955 (bootstrap interval: 0.913407–0.999870)**; **97.5%** of bootstrap replicates fall below one, not a real-world decline probability. SC5 stasis contributes **51.4%** of matrix-cell elasticity (interval: 38.8–64.5%). The primary growth panel has **4,808** records with observed positive live-area endpoints. It projects annualized live-area change over one year, with a 0.1-cm² projected endpoint floor. Consult `heatwave_scenario_summary.csv` and `heatwave_matrix_robustness_summary.csv` for output-backed projection results rather than legacy headline values. This repo supplies parameters to [Detmer-2025-coral-RSE](https://github.com/stier-lab/Detmer-2025-coral-RSE), but the neighboring RSE analyses/app have not been rerun as part of this correction.

## Source-data revision — November 1, 2026

Karen's October 31 inline answers and first-sighting colony-type workbook supersede the earlier date/type holds. Sombrero is explicitly October 19, 2012; twelve verified date-cell corrections are applied as overlays. All observations for MR1-58, MR3-115 and MR3-116 are excluded as ACER. The original workbook is unchanged.

All Neely colonies are wild. First-sighting AF defines a known naturally attached-fragment origin cohort, not outplants or a time-varying morphotype. BR/EN/remnant do not establish nonfragment origin. Two initially loose fragments and both observed deaths remain in the full inventory; they are excluded from the consistently monitored attached-colony primary protocol and the AF subgroup. The descriptive protocol sensitivity retains both deaths. Of 902 named metadata IDs, 874 match the 878-ID extract; four unmatched original IDs have no eligible interval pairs, and 28 metadata-only IDs generate no observations. No AF inference from late appearance, size, site or fate. No new fragmentation-production rate is inferred; Vardi remains the sole matrix production source.

The inventory contains 7,776 survival intervals; primary survival excludes 94 endpoint-selected NOAA fragments and two loose Neely fragments, leaving 7,680. There are no intervals without verified duration. Prepared growth contains 6,319 intervals; the matrix-compatible live-area subset contains 4,808. The separate Neely AF subgroup contributes 677 survival intervals and 414 growth records. All eight subtype groups together have 1,840 survival-estimable intervals and 1,271 growth records; interval survival is descriptive, not an annual or causal origin comparison.

All 73 maintained stages completed successfully in a single fail-fast run, recorded in `06_analysis/output/karen_source_revision_pipeline_manifest.csv` (local execution log: `pipeline_log_20261101_104630.csv`). Targeted display repairs also corrected verified regional labels, restored the lower Garrison CI in the regional forest plot, and clarified the variance-display labels. The deterministic lambda is 0.954753729087; its primary bootstrap interval ends just below replacement (0.913407–0.999870), while some alternative resampling intervals include one. The proportion below one is 97.5%, not a real-world decline probability.

The main Word manuscript (29 pages), supplement (19 pages), and PDFs exported from those Word files are rebuilt. All 48 final document pages have visual coverage: every original page individually inspected, seven revised pages reinspected and 41 unchanged page images verified by exact hashes. Caption/reference fixes are verified; no layout holds remain. All 34 distinct publication/registered figure images have visual coverage. Private current evidence is in `temp/karen_update_2026-11-01/` and `07_reporting/internal/karen_feedback_update_2026-11-01.md`. Source conventions are maintained in `docs/neely_source_conventions.md`. This November 1 revision supersedes the October 30 snapshot (`346f7a4`). The empirical manuscript, supplement and parameter pipeline were updated; the neighboring RSE model/application was not edited or rerun. No journal submission was made.

## Data
| Dataset | Location | Range / sites | Notes |
|---|---|---|---|
| `05_data/standardized/apal_surv_ind.csv` | in-repo | 7,880 interval rows, 7 studies | Source flags: bleaching_2014_context (643), aftermath context (375), storm (571); no diagnosed Neely disease category |
| `apal_growth_ind.csv` | in-repo | ~6,300 obs | Individual growth (AGR + RGR) |
| `apal_surv_summ.csv` / `apal_growth_summ.csv` | in-repo | ~30 / ~20 | Study-level summary rates (Tier 2) |
| `apal_fragmentation.csv` | in-repo | 13 rows | Vardi 2011 only — asexual fecundity F4/F5 by size class |
| `apal_life_history_parameters.csv` | in-repo | ~30 params | Fecundity (oocyte density 63.6/cm², fertilization 95% wild / 15% sibling), maturity threshold 4000 cm², settlement, recruit survival |
| `caribbean_disturbance_events.csv` | in-repo | event-level | Typed events: bleaching 29, disease 31, hurricane 29, cold_snap 1 (region × year) |
| `05_data/original/` | in-repo | 14 raw files | **DO NOT MODIFY** — NOAA, Neely 2022 FKNMS, Kuffner 2020, Fundemar, USGS, Mendoza-Quiroz |
| Florida = 85.5% of survival inventory | — | 6,652 of 7,776 intervals | Generalizability caveat; matched-estimator LOSO retained |

## Pipeline (run order — `06_analysis/scripts/`, all wired into `run_all.R`)
1. **01** data prep → cell-level survival backbone (`prepared_survival_cells.rds`)
2. **02–07** core: survival/growth thresholds (GAM+GLMM), growth AGR/RGR, variance partitioning (model-specific fit and variance components in diagnostic outputs), data gaps, summary integration
3. **08–12** robustness (climate, power, cross-validation, context, model selection) — exploratory/supplementary
4. **13** transition matrix + 2000-iter hierarchical bootstrap λ ← **headline population model**
5. **14 / 14b** meta-analysis: Tier-1 `rma()` (k=6) and expanded three-level `rma.mv()` (k=17, 22 effects) ← **headline meta**
6. **15–17** heterogeneity, sensitivity (matched-estimator LOSO λ 0.888–0.969), parameter-list regeneration; RSE growth exports use live-area endpoints with their own documented eligibility
7. **18, 19, 20b, 22** → **Fig 1–4** (main text)
8. **20c, 21, 23–39, 49/49b** → supplementary figs S1–S28 (disturbance, temporal, regional)
9. **40** Manzello heatwave dose-response scenarios (FigS22)
10. **41–47** advanced dynamic models (multistate, joint longitudinal, stochastic IPM, regime-switching, distributed-lag, frailty, spatiotemporal) — **exploratory robustness only**; only 43/44 reach the supplement via FigS28
11. **50–61** biological-realism 10-scenario framework (S0–S9) → **FigS29**
12. **23_verification**, **48** audit; **run_all.R** orchestrates (~60–75 min)

- **Entry point:** `make pipeline` (wraps `06_analysis/scripts/run_all.R`)
- **Verification gate:** `make verify` refreshes canonical statistics and runs source/prose/model-inventory checks; `make display-check` validates the figure/table index.
- **Headline outputs:** `output/transition_matrix.csv`, `output/population_parameters.csv` (λ=0.954753729087), `output/expanded_meta_analysis_results.csv` (survival 0.789, I²=97.6%), `output/biological_realism_scenarios.csv`

## Current state
- **Done:** full pipeline runs; 4 main figs + S1–S30 (S27 vacant); expanded meta, heatwave, and 10-scenario biological-realism framework all integrated. Recent commits fixed SC1 survival mean (use rma point estimate), SC5 midpoint, and figure-legend sync.
- **Exploratory Fig. S30:** source-specific storm flags and regional heatwave overlap are descriptive/observational. No diagnosed-disease group remains after the Neely source-label correction; absent-category effects are NA. The storm series is explicitly named and colored to prevent a dropped category being labeled as disease.
- **In progress / open threads (from memory):** RSE parameter reconciliations with Raine — inflation 5.63% vs code 0.056; lab survival s_l 0.98 vs 0.95/0.70; data-integration rework (inverse-variance weighting of summary data).
- **Working-tree and environment status:** inspect `git status` and run `make submit-check` under the pinned R environment; this orientation is not a claim that the current checkout is clean or its library synchronized.

## Key architecture facts for analysis work
- **Density-dependence** exists only on **survival** (SC1–SC2 depensatory corallivory, `apply_density_dep_SC12()`, script 58, Williams 2012). **Fecundity is density-INdependent** — `build_F_sex()` uses a fixed 95% fertilization rate. No colony-density × fertilization dataset exists in-repo; the only Allee proxy is the 95%-outcrossed-vs-15%-sibling fertilization contrast (Mendoza-Quiroz 2023).
- **Disturbance × size:** the manuscript uses three contextual states (script 37), not event-specific causal effects. Source-specific NOAA storm flags are distinct from regional overlap. Correcting Neely's 2014 label to bleaching context leaves no diagnosed-disease group in script 37b; disease contrasts are non-estimable. Do not revive the retired disease/predation interpretation.

## Stack & reproduction
R 4.3+; `renv.lock` is present. The lockfile was generated under R 4.5.2; use that version (or an explicitly validated compatible R version) and complete `renv::restore()` before running the R verification gate. All scripts `source("utils/shared_utilities.R")`. Reproduce with `make pipeline`, then `make verify` and `make display-check`. Constants (`SIZE_BREAKS`, palette) and matrix helpers live in `utils/00c_*`, `utils/03_matrix_functions.R`.

## Related
- Sibling model + web app: [Detmer-2025-coral-RSE](https://github.com/stier-lab/Detmer-2025-coral-RSE) + `coral-app/`
- Catalog: `~/repo-catalog/repos/stier-lab__Detmer-2025-coral-parameters.md`
- PRD: `07_reporting/internal/biological_realism_PRD.md`; figure map: `07_reporting/manuscript/figure_table_map.md`; model inventory: `07_reporting/internal/model_inventory.tsv`
- Memory: `project_rse_param_reconciliations`, `project_data_integration_rework`, `project_neely_data_request`
