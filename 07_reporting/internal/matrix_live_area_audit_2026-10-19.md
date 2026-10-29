# Matrix growth measure audit and authorized correction

## Status

Adrian authorized the full live-area correction and downstream rebuild on 19 October 2026. The inherited mismatch described below has been resolved in scripts 13, 16, 17, 36, 49, 50, 60 and the shared matrix helper. The final estimator requires measured initial live area and annual live-area change, excludes nonpositive observed endpoints from conditional growth, and retains 4,301 natural-colony records after near-annual and live-growth filters. It gives lambda 0.940702 (95% bootstrap interval 0.891561–0.982442), not the preliminary substitution-only diagnostic below. Current build and QA evidence is in `live_area_rebuild_2026-10-19.md`. Historical findings and diagnostic values are retained below to document why the correction was needed.

## Confirmed inherited mismatch

`01_data_preparation.R` replaces `size_cm2` with live tissue area where available, preserves original colony size separately, and defines `growth_metric = coalesce(growth_live_cm2_yr, growth_cm2_yr)`. Its comments identify NOAA `growth_cm2_yr` as total skeletal/colony-area growth and `growth_live_cm2_yr` as live-tissue change.

`13_transition_matrix.R` nevertheless constructs final size as `size_cm2 + growth_cm2_yr`. `49_matrix_concordance.R` reconstructs that same estimator, so its passing concordance check cannot detect the mixed response. Script 36 uses the preferentially live-tissue `growth_metric`, so its loss statistic is not a paired decomposition of the current matrix's downward transitions.

Among near-annual natural-colony growth records after the existing impossible-growth filter, 2,867 of 3,125 NOAA records have different `growth_metric` and `growth_cm2_yr`; the median difference is −14.1 cm² yr⁻¹. The 1,245 Neely records have no difference.

## Read-only diagnostic

Retained the saved natural-colony survival vector and fragmentation matrix. Reconstructed the transition matrix once using `growth_cm2_yr` and once using `growth_metric`, applying the same size breaks, annualized growth convention, missing-class handling, and metric-specific 99th-percentile absolute-growth trim. The archived estimator reproduces lambda 0.959489. Substituting the harmonized live-area growth metric gives diagnostic lambda 0.938957; the maximum transition-probability change is 0.084746.

This is not a new final estimate: bootstrap distributions, elasticities, exclusion checks, and heatwave projections have not been recomputed for the harmonized estimator. The diagnostic value must not be substituted into manuscript results while retaining old uncertainty or figures.

## Historical decision and rebuild request

The manuscript's intended live-area interpretation favors a consistent live-area transition estimator, but that changes the reported result rather than simply its wording. Ask Adrian whether to undertake that model revision now. If approved, align scripts 13, 49, 50 and any repeated transition estimators; rerun matrix uncertainty and sensitivities, heatwave projections and complete-matrix comparisons; regenerate Fig. 4 and affected supplementary figures/tables; update reporting gates and every affected manuscript claim from the recomputed outputs. Do not edit only the scalar lambda.

## Separately resolved descriptive drift

Rerunning script 36 exposed older cached summaries containing seven studies despite the maintained natural-colony filter. The regenerated tissue-loss summaries use 4,370 near-annual natural-colony records from two studies: 42.6% loss overall, 21.6% in SC1, and 47.3% in SC5. Current archived-matrix downward-class probabilities are 15.6%, 16.9%, 17.0%, and 9.2% for SC2–SC5. The source text now separates these measures and denominators. These descriptive updates do not resolve the matrix growth-measure mismatch.

## Other checked interpretation

The 36.9–38.9 cm² interval in `growth_thresholds.csv` is stored in compatibility columns named `cluster_boot_*`, but script 03 maps leave-one-study-out threshold percentiles into those fields. The revised Results and Fig. 2 caption name the actual 2.5th–97.5th percentile range. The 37 cm² threshold minimizes the second derivative; it is not the point of steepest first-derivative decline.
