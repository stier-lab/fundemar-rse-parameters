# Live-area rebuild: independent inference audit

Audit date: 2026-10-19. Scope: read-only audit of uncertainty propagation and inference in scripts 13, 49, 50, 40 and 51. This audit does not authorize sending, publishing or pushing files.

## Numerical verification of the corrected primary build

The survivor-only live-area rebuild completed. Read-only independent checks of the saved RDS objects and a reconstruction of the estimator from prepared data passed:

- Deterministic dominant eigenvalue: **0.940702161376**. Reconstructed `G %*% diag(S) + F` matched every saved matrix entry within 1e-10; all five growth-transition columns sum to one.
- All **2,000** saved bootstrap matrices have dominant eigenvalues equal to their stored bootstrap lambdas within 1e-12. No stale total-area bootstrap distribution is attached to the corrected point matrix.
- Bootstrap mean 0.9404795; median 0.9416338; 2.5th–97.5th percentiles **0.8915613–0.9824422**; **1,995/2,000 (99.75%; 99.8% to one decimal)** are below one.
- **120/2,000 (6.0%)** required missing-survival-class point imputation. Discarding these gives 1,880 draws, interval 0.8914041–0.9824422 and fraction below one 99.734%; its mean is 0.0836 percentage points below the imputed mean. This small missing-class sensitivity does not explain the corrected below-replacement estimate.
- Independently reconstructed leave-one-study-out lambdas: Garrison–Ward 0.9401988; Neely 0.9559685; NOAA 0.9355411; Vardi (including fragment production) 0.8770317. Old exclusion values must not survive in prose or tables.
- None of the 2,000 bootstrap projection matrices has an all-zero source column; no empty growth-class source silently erases a size class in this build.
- Matrix-cell elasticities sum to one. SC5-to-SC5 matrix-cell stasis elasticity is **0.541411 (54.1%; bootstrap interval 39.2–68.2%)**. The initial completed-run log printed an older hard-coded 79.0% diagnostic; the parent agent subsequently removed the stale diagnostic from source. It is not the corrected saved result and must not be used in the manuscript.

## Fresh resampling robustness checks

All 6,000 sensitivity draws were independently summarized from `matrix_resampling_draws.csv`; means, percentile limits and fractions below one matched every corresponding summary row to 1e-12.

- Stratified independent: interval **0.8929116–0.9817297**, **99.7%** below one.
- Stratified coordinated: interval **0.8906186–0.9795799**, **99.9%** below one. The coordinated interval does not cross one in this corrected build. Its width is only slightly larger (0.08896 versus 0.08882), while both limits are lower. Report the actual limits, not an impression of a consequential uncertainty change.
- Unstratified independent sensitivity: **99.7%** below one under either point or donor imputation, with the same 95% interval **0.8961176–0.9830233**. Donor imputation changes some individual draws (maximum absolute lambda change 0.01671), but not these rounded quantiles or the fraction below one.
- Removing Vardi survival alone gives lambda **0.9351020** (change −0.0056002); removing its fragmentation alone gives **0.8809246** (−0.0597776); removing both gives **0.8770317** (−0.0636704). Independent eigenanalysis of `A - F` reproduces the fragmentation-only result. Dependence on that single fragment-production source remains material.

## Fresh heatwave outputs

Script 40's new 500-replicate scenarios give baseline effective growth **0.9208603**, with **93.2%** below 10% of starting abundance at year 50. Observed-Florida mortality scenarios give effective growth **0.3507656, 0.5689063, 0.7573004 and 0.8368396** for return intervals **5, 10, 20 and 50 years**, respectively. Every observed-endpoint simulation crosses the year-50 threshold. These are not the old 0.355/0.576/0.768/0.849 results.

The paired 2,000-draw full-matrix check retains the independently verified baseline values in the table below. Under observed Florida mortality, **100%** are below the year-50 threshold for every initial composition and every prescribed recurrence. The old 99.75–100% range therefore must be replaced by 100%. In particular, even adult-heavy full-matrix projections with one event at year 50 have effective growth 0.8693104 and median abundance 0.10495% of initial; this is conditional on the assumed pulse acting equally on all sizes, not new evidence that large colonies have no thermal refuge outside the observed event.

All **136** script-51 endpoint summary rows were independently reproduced to 1e-12 for effective growth and threshold fraction, and to 1e-10 for median percentage. The independent calculation used the fact that size-independent mortality scalars commute with matrix multiplication: project each baseline matrix once, then multiply its year-50 abundance by the product of the prescribed event survivals (with the documented paired random seeds). This reproduces the output through a different algebraic path rather than rerunning its annual projection loop. No discrepancy was found.

## Independent 50-year baseline projection

As a separate check on the matrix-uncertainty machinery, each of the 2,000 corrected matrices was independently multiplied through 50 annual steps for each starting size composition. No annual process noise was added. For the lambda-only comparison, the same bootstrap lambdas scaled the point matrix, also held fixed within a replicate.

| Start | Full-matrix effective growth | Full-matrix share below 10% initial | Lambda-only effective growth | Lambda-only share below 10% initial |
|---|---:|---:|---:|---:|
| Original | 0.9211021 | 92.30% | 0.9212191 | 94.05% |
| Recruit-heavy | 0.9099694 | 97.45% | 0.9100903 | 98.55% |
| Adult-heavy | 0.9573186 | 44.55% | 0.9577379 | 42.95% |
| Stable | 0.9399874 | 73.20% | 0.9401981 | 73.90% |

These conditional finite-horizon growth rates need not equal the deterministic asymptotic eigenvalue. Large starting-size effects survive the corrected input basis; the original projected abundance is not a forecast for an estimated Caribbean-wide starting population.

## What the code-level attack could not break

- The main estimator and the matched study-exclusion/coordination sensitivities call the same strict live-area growth preparation. They use the same natural-colony, near-annual interval and impossible-growth filters and the same absolute-growth 99th-percentile trim. No fallback to total colony area was found in these paths.
- Growth resampling preserves complete observed histories for each sampled colony within each sampled study; it does not independently resample annual records from the same colony. Survival resamples study-level draws and cells within each study draw, then refits the size-class-specific pooling estimator. Fragment-production rows are separately resampled.
- The primary bootstrap draws survival and growth studies independently. Script 50 explicitly tests coordinated shared-study draws against a comparison with the same stratified study mix. This is a study-level dependence sensitivity, not an estimate of temporal covariance.
- Missing survival classes use full-data point estimates in the primary bootstrap. Script 50 separately tests full-data bootstrap donor draws and reports discarded incomplete replicates. These sensitivities must remain visible alongside the primary interval.
- Complete-matrix projection uncertainty holds one sampled matrix fixed within each 50-year replicate. It does not redraw the demographic matrix annually and thereby mislabel estimation uncertainty as annual environmental stochasticity. Heatwave endpoint draws are additional prescribed scenario uncertainty.

## Required interpretation and limits

Report the deterministic eigenvalue separately from the bootstrap mean/interval and from finite-horizon effective growth. The fraction of bootstrap estimates below one is a resampling fraction, not a probability of real-world decline. The matrix omits sexual recruitment. Its replacement interpretation applies only to the modeled survival, live-area movement and fragmentation subsystem.

The annualized endpoint floor of 0.1 cm² is retained only for extrapolated one-year positive-survivor transitions; observed zero-live-area endpoints are excluded from growth conditional on survival. These deaths are represented through the survival component, not reintroduced as SC1 retrogression.

Heatwave outputs are conditional scenarios with prescribed recurrence and assumed size-independent pulses. Uniform draws over the observed Florida mortality range are not a fitted environmental process. Threshold-crossing shares therefore must not be represented as regional extinction probabilities or calibrated forecasts.

## Existing non-load-bearing labels worth keeping out of prose

Script 13 retains legacy parameter names such as `p_decline`; the underlying quantity is a bootstrap share. The parent agent corrected its old probability-style CSV note in source after the initial audit. Its exploratory `parametric_uncertainty_lambda` is computed from finite-horizon log ratios with a +1 pseudocount, so it is not exactly the sampled matrix eigenvalue despite an older adjacent comment. The manuscript's primary deterministic lambda comes from the matrix eigenvalue; the 50-year scenario/robustness outputs do not use that exploratory pseudocount statistic. Do not promote it into the revised main results.

## Interface contract and final disposition

The complete `tools/check_live_area_contract.R` gate passed after scenario rebuilding: **4,301** primary growth records; corrected lambda **0.940702161376**; all **2,000** bootstrap matrices coherent. Field and nursery export bundles retain the live-area-survivor marker and finite nonnegative probability vectors that sum to one within each source class. The rebuilt S0 scenario exactly matches the canonical projection matrix and lambda. Negative toy tests reject missing-live measurements despite available total-area growth, and reject observed dead endpoints as survivor transitions.

No inference defect was found in the corrected load-bearing uncertainty/projection paths. Necessary reporting changes are the new point/interval, resampling counts, elasticities, study exclusions and projections above, with the recruitment-free and conditional-scenario ceilings retained.

**Supported sentence:** Using consistent live-planar-area growth among surviving colonies, the compiled recruitment-free transition subsystem has a deterministic lambda of 0.941 (95% bootstrap interval 0.892–0.982); its below-replacement estimate persists under the tested study-resampling and missing-class sensitivities, while fragment-production evidence and starting size structure remain important limitations.
