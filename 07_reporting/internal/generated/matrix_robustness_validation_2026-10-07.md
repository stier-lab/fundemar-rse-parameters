# Matrix robustness validation — 7 October 2026

## Scope and locked reproduction

An isolated copy of the working repository was initialized with its own Git
root and restored with renv under R 4.5.2, the version in renv.lock. Prepared
data and the complete 2,000-replicate primary matrix bootstrap were
regenerated. This supersedes the incomplete R 4.6.1 verification described in
the 6 October prose audit.

The reconstructed matrix lambda is 0.959489041709. Every regenerated bootstrap
lambda is exactly identical to the saved draw, not merely equal after
rounding: maximum absolute difference 0. The percentile interval is
0.902052568711–1.000680229850; 97.1% of estimates are below one. There are 132
replicates with at least one imputed survival class. The main text, Figure 4,
canonical statistics, and README use these values.

The regenerated prepared files improve population metadata: nursery records
formerly missing data_type have nursery_in labels. The primary natural-colony
matrix and bootstrap do not change. A missing recruit-survival estimate is
now explicitly treated as unavailable rather than passed to a scalar
comparison; no recruit-survival value was invented.

Run tools/check_clean_matrix_rerun.R with the isolated repository path to
check the matrix, all bootstrap draws, and the three new sensitivity
summaries. Its comparisons passed under locked R.

## Survival–growth coordination and missing classes

Script 50_matrix_robustness.R uses 2,000 replicates per sensitivity, seed
20261007, the primary annualized study-level survival estimator, the same
natural-colony growth filters, and annual fragmentation-row resampling.

| Treatment | Percentile interval | Lambda below one |
|---|---|---|
| Primary, point imputation | 0.902–1.001 | 97.1% |
| Primary, incomplete draws discarded | 0.901–1.000 | 97.3% |
| Independent sensitivity, point imputation | 0.903–1.002 | 96.9% |
| Independent sensitivity, distribution imputation | 0.903–1.002 | 96.9% |
| Fixed study mix, independent draws | 0.901–1.000 | 97.5% |
| Fixed study mix, coordinated shared-study draws | 0.891–1.005 | 95.6% |

The coordinated comparison holds the study mix fixed. It tests shared
study-level resampling, not within-colony or temporal survival–growth
covariance. Distribution imputation propagates uncertainty conditional on
the observed studies; it cannot create information from missing populations.
Discarding incomplete draws conditions on observed class coverage.

## Vardi component exclusions and elasticity

With the primary estimator and growth fixed, excluding Vardi survival alone
gives lambda 0.954377254387; excluding fragmentation alone gives
0.891897421489; excluding both gives 0.888726057217. The combined exclusion is
therefore mainly a fragmentation effect, not evidence that Vardi growth
records drive the matrix. Vardi supplied no paired individual growth records.

SC5-to-SC5 stasis elasticity is 59.8% (bootstrap interval 37.9–71.9%).
Aggregated SC5 survival elasticity is a different quantity, 61.2%. Neither
estimates an intervention's effectiveness or cost.

## Complete-matrix projections and initial composition

Script 51_heatwave_matrix_robustness.R uses every valid primary bootstrap
matrix and its paired lambda-only version. Each matrix is retained for 50
years. Event draws are paired across methods and initial compositions.
Original, recruit-heavy, adult-heavy, and stable compositions are
sensitivity assumptions, not regional observations.

Without heatwaves, full-matrix projections for the original composition
give effective lambda 0.935 and 78.0% below 10% of initial abundance at year
50. The paired lambda-only value is 80.3%. The older primary figure's 78.4%
uses 500 simulations, not this all-2,000 comparison. Main Methods, Results,
and the Fig. S6 caption identify the denominators.

Full-matrix baseline endpoint fractions range from 24.0% for adult-heavy
starts to 90.6% for recruit-heavy starts. Observed Florida mortality at
50-year recurrence gives 99.75–100% below the endpoint threshold across
methods and starting compositions; shorter tested return intervals put
every simulation below it. Uniform survival from 0–2.2% is a stress-test
assumption based on reported bounds, not an estimated mortality distribution.

The finite-horizon effective rate includes transient composition and
parameter uncertainty; it is not the matrix eigenvalue. Endpoint and
ever-crossed threshold fractions agree for baseline and observed-Florida
scenarios, but not all dose-response scenarios. No sexual recruitment,
immigration, density dependence, or annual environmental variation in matrix
transitions is added.

## Manuscript and render verification

ESM Tables S3 and S4 report the sensitivity results. All six S3 rows, all
eight S4 rows, and load-bearing main-text claims pass 20 source-output
checks. The independent prose diagnostic confirmed numerical agreement and
prompted explicit denominators and bounded interpretation.

Both documents were rebuilt and exported from Word through LibreOffice.
All 21 main-text pages and all 12 ESM pages were visually inspected.
Table headers, decimal precision, units, citations, figures, and page breaks
were checked. Tables have no vertical rules. The render scripts now export
PDF from the formatted DOCX rather than constructing a separate LaTeX layout.
The submission gate passed under R 4.5.2 with a synchronized renv library.

The broader pipeline was also rerun in the isolated copy, with logged
continuations after repairs. Every one of the 73 maintained scripts has a
successful execution record across those continuations; this was not a
single uninterrupted run. The final continuation passed all 18 remaining
steps. The run logs, R session information, and successful-script crosswalk
are retained in `locked_rerun_2026-10-07/` beside this report.

Font exports use Cairo, restoration growth
classification uses a vector-valued predicate, empty within-region
comparisons are identified rather than tested with zero sample size, and
spatiotemporal prediction grids include their population-type covariate.
Frozen DHW and SST cache reuse is explicit with APAL_OFFLINE=true;
missing environmental observations are not replaced by invented values.
The auxiliary hurricane script downloaded its IBTrACS input from NOAA
because its temporary cache was absent. That input is not used by the
primary matrix or the new heatwave sensitivity analysis.
Successful script execution is not a claim that exploratory models are
identifiable or suitable for primary inference.
