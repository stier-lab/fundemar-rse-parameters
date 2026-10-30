# Orientation — Detmer-2025-coral-parameters

_Last reviewed: 2026-10-30 · branch `codex-pipeline-refresh-automation`. Consult `git status` for the working-tree state; this repository intentionally tracks regenerated analysis outputs._

## What this is
PRISMA-structured systematic review + meta-analysis of **size-dependent demography in the Caribbean elkhorn coral *Acropora palmata***, targeting *Coral Reefs*. The synthesis includes 18 studies; the survival meta-analysis uses 17 studies and 22 effects across 13 Caribbean regions. Pooled annual survival is **0.789 (95% CI 0.707–0.852; PI 0.380–0.958)** under extreme heterogeneity (**I² = 97.6%**), from the interval-annualized three-level `rma.mv()`. The corrected recruitment-free transition matrix gives **λ = 0.953 (bootstrap interval: 0.913–1.000)**; **97.4%** of bootstrap replicates fall below one, not a real-world decline probability. SC5 stasis contributes **51.5%** of matrix-cell elasticity (interval: 38.8–64.7%). The primary growth panel has **4,791** records with observed positive live-area endpoints. It projects annualized live-area change over one year, with a 0.1-cm² projected endpoint floor. Consult `heatwave_scenario_summary.csv` and `heatwave_matrix_robustness_summary.csv` for output-backed projection results rather than legacy headline values. This repo supplies parameters to [Detmer-2025-coral-RSE](https://github.com/stier-lab/Detmer-2025-coral-RSE), but the neighboring RSE analyses/app have not been rerun as part of this correction.

## Source-data revision — October 30, 2026

The latest local revision separates natural fragmentation from restoration
origin, excludes two collector-identified non-APAL colonies, and applies one
verified survey-date correction without changing the original workbook.
The inventory contains 7,778 survival intervals; primary survival inputs exclude
94 live-endpoint-selected natural-fragment records and 21 intervals without
verified duration, leaving 7,663. Valid survivor growth remains eligible by its
measurement/duration rules. Neely's unreported physical colony types are U;
they retain natural origin. Nursery-held material and natural fragments have no
post-outplant age in the age model. Source conventions and correction provenance
are in `docs/neely_source_conventions.md` and `05_data/corrections/`.

All 73 maintained analysis stages were rerun across logged fail-fast segments;
source/eligibility fixes and display repairs were verified before continuing.
The updated deterministic lambda is 0.953429255573; the bootstrap interval
includes replacement (0.912684–1.000140), with 97.4% of replicates below one.
The sources, figures, tables, main Word manuscript (29 pages), supplement Word
document (19 pages), and PDFs exported from those Word files are synchronized
to these results. All 48 final document pages and 34 distinct publication/registered
figure images have visual coverage; exact hashes and review evidence are private
in `temp/karen_source_update_2026-10-30/`. Source/coherence, citation, display,
Word-package and pinned-environment checks pass. The diagnostic CV study grouping
is now a factor: all 25 candidate-model folds fit, including the formerly failing
GAM. `06_analysis/output/karen_source_revision_pipeline_manifest.csv` records the
73 successful stages across five fail-fast segments; final display/CV reruns are
listed in the source-update ledger. The October 30 source-data rebuild supersedes the earlier
manuscript-only snapshot `bf8bd59`. Correction overlays, pipeline outputs and
manuscript artifacts are maintained together on this branch; consult Git history
for the publication state. Neighboring RSE application analyses were
not rerun by this demographic-synthesis update.

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
| Florida = 85.5% of survival inventory | — | 6,654 of 7,778 intervals | Generalizability caveat; matched-estimator LOSO retained |

## Pipeline (run order — `06_analysis/scripts/`, all wired into `run_all.R`)
1. **01** data prep → cell-level survival backbone (`prepared_survival_cells.rds`)
2. **02–07** core: survival/growth thresholds (GAM+GLMM), growth AGR/RGR, variance partitioning (model-specific fit and variance components in diagnostic outputs), data gaps, summary integration
3. **08–12** robustness (climate, power, cross-validation, context, model selection) — exploratory/supplementary
4. **13** transition matrix + 2000-iter hierarchical bootstrap λ ← **headline population model**
5. **14 / 14b** meta-analysis: Tier-1 `rma()` (k=6) and expanded three-level `rma.mv()` (k=17, 22 effects) ← **headline meta**
6. **15–17** heterogeneity, sensitivity (matched-estimator LOSO λ 0.888–0.966), parameter-list regeneration; RSE growth exports use live-area endpoints with their own documented eligibility
7. **18, 19, 20b, 22** → **Fig 1–4** (main text)
8. **20c, 21, 23–39, 49/49b** → supplementary figs S1–S28 (disturbance, temporal, regional)
9. **40** Manzello heatwave dose-response scenarios (FigS22)
10. **41–47** advanced dynamic models (multistate, joint longitudinal, stochastic IPM, regime-switching, distributed-lag, frailty, spatiotemporal) — **exploratory robustness only**; only 43/44 reach the supplement via FigS28
11. **50–61** biological-realism 10-scenario framework (S0–S9) → **FigS29**
12. **23_verification**, **48** audit; **run_all.R** orchestrates (~60–75 min)

- **Entry point:** `make pipeline` (wraps `06_analysis/scripts/run_all.R`)
- **Verification gate:** `make verify` refreshes canonical statistics and runs source/prose/model-inventory checks; `make display-check` validates the figure/table index.
- **Headline outputs:** `output/transition_matrix.csv`, `output/population_parameters.csv` (λ=0.953429255573), `output/expanded_meta_analysis_results.csv` (survival 0.789, I²=97.6%), `output/biological_realism_scenarios.csv`

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
