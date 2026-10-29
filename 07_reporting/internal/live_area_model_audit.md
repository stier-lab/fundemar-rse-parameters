# Independent model-validity and provenance audit: live-area transition correction

Date: 2026-10-19. Read-only attack on the estimator and underlying data; no model, input-data, manuscript, or email changes made by this auditor.

## Scope and disposition

The inherited matrix mixed initial live area with total-colony-area change for many NOAA observations. That mismatch is real, and correcting only the scalar lambda would be invalid. The authorized correction is to use measured initial live area plus annual live-area change, preserving the natural-colony restriction, near-annual intervals, existing impossible-growth filter, 99th-percentile trimming convention, survival pooling, and fragmentation model. No sexual-fecundity term is warranted by this correction.

## Independent reconstruction

Read `prepared_growth_data.rds` and the pre-rebuild `transition_matrix.rds`, reconstructed transition counts directly with base-R `cut()` and `table()`, and retained its saved survival vector and fragmentation matrix. The source size breaks are 0, 10, 100, 900, 4,000, Inf cm²; matrix rows are destination and columns are initial class.

| Estimator | Eligible before trim | After metric-specific strict `< q99` trim | Lambda |
|---|---:|---:|---:|
| Inherited initial-size + total-area change | 4,370 | 4,326 | 0.959489041709 |
| Preferential-live coalesced change | 4,370 | 4,326 | 0.938956889515 |
| Strict measured live initial area + measured live-area change | 4,369 | 4,325 | 0.938963622580 |
| Strict live measurements, additionally conditional on observed survival | 4,345 | 4,301 | 0.940702161376 |

The strict estimator's absolute annual-change q99 is 10,357.89 cm² yr⁻¹. After trimming, NOAA contributes 3,083 observations and Neely et al. contributes 1,242. Initial-class counts are 37, 590, 1,225, 1,155, and 1,318. Every transition column sums to one.

The inherited calculation reproduces its stored lambda, independently confirming the old estimator rather than relying on the script-49 concordance gate. The strict live-only estimate differs slightly from the earlier preliminary coalesced-live diagnostic because one non-live row must be excluded.

## Provenance attack: units and fallback

Among the eligible observations, all 3,124 NOAA records with live-growth measurements and all 1,245 Neely records have both measured live initial size and measured live-area change. Their prepared `size_cm2` equals `size_for_class`, and their `growth_metric` equals `growth_live_cm2_yr`.

One additional NOAA record is **not** live-area data: Florida Keys, Grecian Rocks, plot GR3, colony GR3-t901, survey year 2018. Both `size_live_cm2` and `growth_live_cm2_yr` are missing. Its prepared initial size is total colony area, 1,127 cm², and its change falls back to total colony area (approximately −160 cm² yr⁻¹, interval approximately 1.13 yr). Exclude this record from a strict live-area transition estimator; do not infer 100% live tissue from absent measurements. The main agent was notified before patching.

Checked all **3,124 eligible NOAA live-growth records against original measurements**, using `05_data/original/NOAA_Tagged_Colony_Data.csv` and `NOAA_Dem_Survey_Dates.csv`:

- Initial area matches original length × width × percent live / 100 for the tagged colony.
- Measured endpoint area equals initial live area + recorded annual live-area change × recorded interval, with absolute error below 10⁻⁵ cm².
- The corresponding raw endpoint date equals raw initial date + round(interval × 365) days.
- All 3,124 records passed; there is no need for a second annualization division.

For Neely, `00_standardize_neely.R` derives growth as `(lai_end - lai_start) / time_interval_yr`, with time in days/365.25, only among survivors; `lai_start` is explicitly the live-area index and the resulting annual rate is copied to `growth_live_cm2_yr`. This source already used consistent live area in the inherited matrix, so its metric does not change.

## Filters, annualized endpoint, and bootstrap attack

**Additional verified conditional-transition issue:** 24 of the 4,369 strict-live eligible observations have observed endpoint live area equal to zero (numerical tolerance 10⁻⁶ cm²). A one-to-one study/colony/year join to prepared survival data confirms that all 24 are NOAA records with `survived == 0`. All remaining 3,100 NOAA and 1,245 Neely observations have positive observed endpoint and `survived == 1`; there are no unmatched records or contradictory classifications. A growth transition matrix multiplied by a separate survival probability should be conditional on survival, not reinterpret these observed deaths as tiny surviving colonies. The main agent was notified of this evidence and the independently reconstructed survivor-conditioned reference value.

Excluding the 24 observed deaths before q99 trimming gives 4,345 eligible and 4,301 retained records, with q99 = 10,393.64 cm² yr⁻¹; NOAA contributes 3,059 and Neely 1,242. Its point lambda is 0.940702161376. This additional consistency correction does not add fecundity or alter the annualization estimand. It must be documented explicitly if adopted rather than attributed solely to choosing the live-growth column.

The prepared `impossible_growth` flag uses the same coalesced live-area numerator and initial live area, with the established relative annual-change bounds (loss beyond 110% or gain above 300%). It therefore does not accidentally screen live-area transitions using NOAA's skeletal-change numerator. The allowed 0.5–1.5 yr intervals remain unchanged.

Under the strict live-only estimator, 44 trimmed observations produce an annualized one-year endpoint below 0.1 cm². They have relative annual changes between approximately −1.09 and −1.00 and observed intervals approximately 0.616–1.000 yr. These are retained by the established 10% loss tolerance and mapped to the existing 0.1 cm² floor. This is an inherited annualized linear-projection/clamping convention, not a newly introduced unit error. It must remain accurately described; it should not be called directly observed one-year endpoint size. The correction does not authorize a different annualization estimand or new biological mechanism.

With observed deaths excluded, 31 surviving-colony observations still require this one-year extrapolation floor. Positive observed endpoint and a negative annualized one-year extrapolation can coexist for subannual intervals, so do not exclude those 31 merely by conflating projected and observed endpoints.

The primary bootstrap resamples `growth_filtered` by study and colony, then counts its precomputed initial/final class labels. Thus corrected labels and metric-specific trimming propagate to all primary growth resamples, provided the canonical corrected data feed that object. Secondary repeated estimators (scripts 49/50 and the shared matrix helper) must use the same metric and strict live-only eligibility. Reusing an old bootstrap or changing the labels only for the deterministic matrix would not pass this audit.

## Claim ceiling

The supported statement after survivor conditioning is: **The natural-colony projection matrix constructed from consistent live-area growth among observed survivors has a point estimate of lambda approximately 0.941, conditional on the existing survival, fragmentation, filtering, annualization, and sampling assumptions.** New uncertainty limits, elasticity values, exclusion results, and projections require fresh downstream output; none are inferred from the point-estimate reconstruction here.

## Final implementation verification

Read the main agent's patched `prepare_live_area_growth()` helper and scripts 13, 49, and 50. The helper now requires finite measured live initial area, finite measured live change, positive finite duration, and positive observed endpoint; it preserves raw total-area columns. It does not conflate the observed endpoint with the one-year extrapolation.

Executed the patched helper and independently counted destination/initial transitions with base R. It gives 4,345 eligible and 4,301 trimmed records, initial-class counts 36, 582, 1,213, 1,152, and 1,318, with lambda **0.940702161376**, matching the independent survivor-conditioned reconstruction to better than 10⁻¹¹. All columns sum to one and all retained records carry `growth_measure = live_planar_area_survivor`. Scripts 49 and 50 now use the same helper and live-area metric; the primary bootstrap uses the corrected precomputed class labels. Final regenerated uncertainty/projection outputs remain the responsibility of the main pipeline audit, not evidence inferred by this read-only point-estimator check.
