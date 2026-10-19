---
title: "Online Resource 1: Supporting analyses for size-dependent demography, disturbance, and transition dynamics of *Acropora palmata* across the Caribbean"
author: "Adrian C. Stier; A. Raine Detmer; Karen L. Neely; Tali Vardi; Darcy Bradley; Aldo Croquer; Rita I. Sellares-Blasco; Jameal F. Samhouri"
date: ""
bibliography:
  - paper/manuscript/references.bib
  - paper/manuscript/palmata_library.bib
link-citations: true
header-includes:
  - \usepackage{pdflscape}
  - \usepackage{booktabs}
  - \usepackage[margin=0.5in]{geometry}
---

**Journal:** *Coral Reefs*  
**Corresponding author:** Adrian C. Stier, Department of Ecology, Evolution, and Marine Biology and Marine Science Institute, University of California, Santa Barbara, CA 93106, USA.

**Corresponding author email:** astier@ucsb.edu.

## Contents

1. Eighteen studies supported the synthesis (Table S1)
2. Disturbance exposure was pervasive in Tier 1 intervals (Table S2)
3. Size-dependent survival and growth showed distinct thresholds (Fig. S1)
4. Study identity confounded population-origin comparisons (Fig. S2)
5. Surviving colonies often lost tissue and retrogressed (Fig. S3)
6. Size--survival associations varied among disturbance states (Fig. S4)
7. Restoration estimates varied among colony-source subtypes (Fig. S5)
8. Florida-scale heatwaves reduced recruitment-free projections (Fig. S6)
9. Resampling choices changed uncertainty more than the central estimate (Table S3)
10. Initial composition changed finite-horizon projections (Table S4)

**Study selection.** Consolidating duplicate and within-study entries reduced 104 screening-ledger rows to 101 distinct sources: 83 excluded and 18 included (seven individual-record studies and eleven summary studies). Seventeen studies supplied 22 survival-synthesis effects; Mendoza Quiroz et al. [-@mendozaquiroz2023] contributed only to size-dependent analyses. Approximately 2,500 records were identified, but inconsistent early screening totals prevent an exact PRISMA flow. The repository ledger retains all screening decisions.

\clearpage

## 1. Eighteen studies supported the synthesis

**Table S1. Eighteen studies contributed data; seventeen entered the survival synthesis.** Tier 1 studies supplied individual colony records; Tier 2 studies supplied study-level summaries. *N* is the effective annualized denominator in the survival synthesis after interval filtering and aggregation, summed across a study's effects; survival is the *N*-weighted mean of annualized effect-level survival and is shown for orientation only (Fig. 3 gives random-effects estimates). Roles: S, survival synthesis; V, size-dependent vital-rate models; M, transition matrix (natural-colony survival and growth). Fragmentation in the matrix came only from Vardi [-@vardi2011], whose summaries also entered the survival synthesis.

| Study | Tier | Region(s) | Population type | Effects | *N* | Survival (%) | Roles |
|:----------------------------|:--|:-------------------|:------------|---:|----:|-----:|:-------|
| NOAA monitoring | 1 | Florida Keys, Curaçao, Navassa | Natural | 3 | 3,874 | 87.4 | S, V, M |
| Neely et al. [-@neely2022] | 1 | Florida Keys | Natural | 1 | 2,191 | 70.2 | S, V, M |
| Pausch et al. [-@pausch2018] | 1 | Florida Keys | Restoration | 1 | 968 | 57.4 | S, V |
| Kuffner et al. [-@kuffner2020] | 1 | Florida Keys | Restoration | 1 | 53 | 81.1 | S, V |
| USGS outplant experiment (unpublished) | 1 | US Virgin Islands | Restoration | 1 | 46 | 65.5 | S, V |
| FUNDEMAR fragments (unpublished) | 1 | Dominican Republic | Restoration | 1 | 44 | 86.6 | S, V |
| Mendoza Quiroz et al. [-@mendozaquiroz2023] | 1 | Mexican Caribbean | Restoration (sexual outplants) | -- | -- | -- | V |
| Vardi [-@vardi2011] | 2 | Jamaica, Puerto Rico, Virgin Gorda | Natural | 3 | 245 | 86.9 | S, M |
| Bruckner and Bruckner [-@bruckner2001] | 2 | Puerto Rico | Restoration | 1 | 105 | 90.5 | S |
| Ortiz Prosper [-@ortizprosper2005] | 2 | Puerto Rico | Restoration | 1 | 207 | 78.7 | S |
| Forrester et al. [-@forrester2013] | 2 | British Virgin Islands | Restoration | 1 | 257 | 53.3 | S |
| Rosales et al. [-@rosales2024] | 2 | Florida Keys | Restoration | 1 | 58 | 79.3 | S |
| Maurer et al. [-@maurer2022] | 2 | Bahamas | Restoration | 1 | 24 | 95.8 | S |
| Williams and Miller [-@williamsmiller2010] | 2 | Florida Keys | Restoration | 1 | 18 | 77.8 | S |
| Garrison and Ward [-@garrison2008] | 2 | US Virgin Islands | Natural and restoration | 2 | 75 | 69.3 | S, M |
| Rogers and Muller [-@rogersmuller2012] | 2 | US Virgin Islands | Natural | 1 | 69 | 94.2 | S |
| Ramos Romero et al. [-@ramosromero2025] | 2 | Cuba | Restoration | 1 | 200 | 70.5 | S |
| Rogers et al. [-@rogers1982] | 2 | US Virgin Islands | Natural | 1 | 173 | 48.0 | S |
| **Total** | | | | **22** | **8,607** | | |

The total denominator comprises 7,176 Tier 1 colony-interval records and 1,431
from Tier 2 effect-level sample sizes; it is not a count of unique colonies.
The prepared Tier 1 survival file contains 7,346 records, of which 52 Mendoza
Quiroz records, 24 Neely records without usable interval duration, and 94 NOAA
restoration-fragment records did not enter these survival-synthesis effects.

\clearpage

## 2. Disturbance exposure was pervasive in Tier 1 intervals

**Table S2. Curated disturbance overlap was pervasive across the demographic records.** The study-window summary links 1,072 prepared survival intervals from the seven Tier 1 studies to the curated disturbance timeline. Only 53 intervals (4.9%) overlapped no curated event. "Baseline exclusion" identifies the 297 intervals removed only in the acute-event sensitivity analysis; it does not mean that other intervals were undisturbed.

| Study | Intervals | No overlap | One event | Two or more events | Baseline exclusion | Any overlap (%) |
|:--|--:|--:|--:|--:|--:|--:|
| NOAA monitoring | 842 | 50 | 59 | 733 | 228 | 94.1 |
| Neely et al. [-@neely2022] | 98 | 3 | 0 | 95 | 10 | 96.9 |
| Pausch et al. [-@pausch2018] | 70 | 0 | 0 | 70 | 46 | 100.0 |
| USGS outplant experiment | 27 | 0 | 15 | 12 | 12 | 100.0 |
| Kuffner et al. [-@kuffner2020] | 27 | 0 | 0 | 27 | 0 | 100.0 |
| Mendoza Quiroz et al. [-@mendozaquiroz2023] | 7 | 0 | 0 | 7 | 0 | 100.0 |
| FUNDEMAR fragments | 1 | 0 | 0 | 1 | 1 | 100.0 |
| **Total** | **1,072** | **53** | **74** | **945** | **297** | **95.1** |

The interval linkage had no field mismatches. The full disturbance chronology, interval-level assignments, and extended diagnostics are available in the project repository.

\clearpage

## 3. Size-dependent survival and growth showed distinct thresholds

**Fig. S1. Survival and growth change with colony size at different points in ontogeny.** (a) Annual survival against log live planar area; the label gives the improvement of the GAM over a linear model (ΔAICc = 17.9; the pre-specified gate for reporting a threshold was 2). (b) Probability of positive growth; the dashed line marks the supported threshold (411 cm²). (c) Second derivative of the relative-growth-rate GAM; the dashed line marks the steepest change in curvature (37 cm²). (d, e) Absolute growth rate (AGR, cm² yr^−1^) and relative growth rate (RGR, yr^−1^) against colony size. (f) Probability of positive growth fitted with a lower-dimension smooth (*k* = 3), which captures the broad U-shaped trend but not the dome detected in panel b. (g) Standard deviation of AGR and RGR within size bins on a log scale: AGR variance rose by more than two orders of magnitude across the size range, whereas RGR variance declined. Points are binned observations, lines are GAM fits, and ribbons or error bars are 95% confidence intervals. Analyses exclude the upper and lower 0.5% of relative-growth values to limit leverage by extreme proportional changes and exclude high-variance Navassa records.

![](06_analysis/figures/supplementary/FigS1_growth_diagnostics.pdf){ height=130mm }

\clearpage

## 4. Study identity confounded population-origin comparisons

**Fig. S2. Natural-colony and restoration-fragment comparisons are confounded by study identity and a narrow shared size range.** Each facet shows one Tier 1 study within the size range shared by natural and restoration records. (a) Annual survival and (b) relative growth rate (yr^−1^) against initial live tissue area (cm²). Points are observations, coloured lines are study-specific binomial GLM (a) or linear model (b) fits on log size, shaded bands are 95% confidence intervals, and labels give population type and sample size. The shared range (11–202 cm²) is small relative to the full 1–15,000 cm² range, and within it survival slopes differed in sign among studies, so this comparison is descriptive rather than a causal estimate of restoration origin.

![](06_analysis/figures/supplementary/FigS8_natural_vs_restoration.pdf){ width=174mm }

\clearpage

## 5. Surviving colonies often lost tissue and retrogressed

Size classes are live-area ranges, not observations of reproductive maturity. Soong and Lang [-@soonglang1992] reported a smallest fertile *A. palmata* colony of 16 × 8 cm and an operational puberty size of 1,600 cm² in Panama. They defined puberty size as the size of the smallest colony in the first group of 20 consecutively size-ranked colonies with at least 90% fertility. For *A. palmata*, they summed the living surface area of branches and the colony base. Fertility indicated gonads in sampled tissue, not observed spawning. Those measurements are not directly interchangeable with our live planar areas. We therefore did not assign fertility to a model class or treat retrogression as loss of reproductive capacity. Neither reproductive output nor three-dimensional habitat complexity was estimated in this analysis.

**Fig. S3. Large colonies commonly survived while losing tissue, and every non-recruit class moved backward through the size structure.** (a) Shrinkage frequency among surviving colonies by size class, rising from 18.2% in SC1 to 47.5% in SC5. (b) Mean annual tissue loss among shrinking colonies (cm² yr^−1^). (c) Observed annual transition probabilities (growth, stasis, retrogression) by initial size class; labels give retrogression probabilities. (d) Shrinkage frequency by study; point colour gives mean tissue loss and point size the number of records. The analysis uses matrix-compatible records of surviving colonies with paired size observations.

![](06_analysis/figures/supplementary/FigS16_shrinkage_retrogression_summary.pdf){ width=174mm }

\clearpage

## 6. Size--survival associations varied among disturbance states

**Fig. S4. The relationship between size and survival differed among curated disturbance states, but not as a simple disturbance penalty.** Tiles give observed (a) annual survival and (b) probability of positive growth by size class and disturbance state for natural colonies (*n* = 6,141 survival records). Tile labels are percentages. The size-by-state interaction was supported for survival (likelihood-ratio test, *p* < 0.001) and weaker for positive growth (*p* = 0.010). Large colonies survived better in intervals flagged for acute events (SC5, 98.0%, *n* = 409) than in intervals with no curated event (SC5, 83.9%, *n* = 193). The no-disturbance category contained only 353 records, including a single SC1 colony, so its SC1 tile is not interpretable. Disturbance states are observational and confounded with study, site, and survey period.

![](06_analysis/figures/supplementary/FigS17_disturbance_size_interaction.pdf){ width=174mm }

\clearpage

## 7. Restoration estimates varied among colony-source subtypes

**Fig. S5. Apparent restoration performance depends on the colony source grouped under each label.** (a) Annual survival and (b) mean relative growth rate (yr^−1^) for naturally occurring fragments (3,968 records, one study), nursery outplants (1,012 records, two studies), nursery outplants re-cemented after fragmentation (53 records, one study), and outplanted colonies (46 records, one study). Open circles are study summaries, with symbol size proportional to records; filled diamonds are record-weighted subtype means, and horizontal lines span the study summaries. These contrasts are descriptive because subtype, study, site, handling, and sample size are not independently balanced.

![](06_analysis/figures/supplementary/FigS19_restoration_subtype_sensitivity.pdf){ width=174mm }

\clearpage

## 8. Florida-scale heatwaves reduced recruitment-free projections

**Fig. S6. Recurrence of Florida-scale heatwave mortality drives effective lambda far below one in the recruitment-free transition subsystem.** (a) Logistic mortality curve parameterized from the *A. palmata* DHW thresholds reported by Manzello et al. [-@manzello2025] (ED50 = 7.8 DHW; ED95 = 17.6 DHW); the shaded range marks the 16–20 DHW exposure in the Florida Keys in 2023. (b) Median 50-year trajectories and 95% simulation intervals without heatwaves and for the observed 2023 Florida endpoint (97.8–100% mortality) at four return intervals; the dashed line marks the quasi-extinction threshold of 10% of initial abundance. (c) Effective lambda across dose-response and observed-endpoint scenarios; bars are geometric means of annual abundance ratios from simulations that scale the fixed matrix structure by one bootstrap lambda per replicate, and the dotted line is the unperturbed deterministic lambda (0.959). Each scenario used 500 simulations. Without heatwaves, effective lambda was 0.935 and 78.4% of simulations were below the quasi-extinction threshold at year 50; every observed-endpoint scenario was below that threshold at year 50 in all simulations. The 5-, 10-, 20-, and 50-year intervals span frequent to rare recurrence and are sensitivity values, not estimated return periods. These are Florida-like event stress tests, not Caribbean-wide forecasts.

![](06_analysis/figures/supplementary/FigS22_heatwave_scenarios.pdf){ width=174mm }

\clearpage

## 9. Resampling choices changed uncertainty more than the central estimate

**Table S3. Alternative resampling choices left lambda predominantly below replacement.** All analyses used the five-class recruitment-free matrix, annualized study-level survival pooling, near-annual natural-colony growth transitions, and row-resampled annual fragmentation estimates. Intervals are 2.5th–97.5th bootstrap percentiles; the final column is the percentage of lambda estimates below one, not a probability of decline in a real population. *n* is the number of retained replicates. Analyses used R 4.5.2 and the project’s locked package versions.

| Resampling and missing-class treatment | *n* | Replicates imputed | 95% interval | Below one (%) |
|:--------------------------------------|----:|--------:|:-------------|--------------:|
| Primary independent, point imputation | 2,000 | 132 | 0.902–1.001 | 97.1 |
| Primary independent, discard incomplete | 1,868 | 0 | 0.901–1.000 | 97.3 |
| Independent sensitivity, point imputation | 2,000 | 133 | 0.903–1.002 | 96.9 |
| Independent sensitivity, distribution imputation | 2,000 | 133 | 0.903–1.002 | 96.9 |
| Fixed study mix, independent | 2,000 | 0 | 0.901–1.000 | 97.5 |
| Fixed study mix, coordinated | 2,000 | 0 | 0.891–1.005 | 95.6 |

The primary bootstrap drew four survival studies and two growth studies independently, then resampled survival cells and colony growth records within each selected study. The independent sensitivity used a separate seed; within each replicate, point imputation and distribution imputation used identical survival, growth, and fragmentation draws. For a missing survival class, distribution imputation replaced its full-data point estimate with a survival draw from that class’s full-data bootstrap distribution. This propagated conditional sampling uncertainty, but did not supply evidence from an unobserved population.

For the fixed-study-mix comparison, both versions sampled two study instances from the two shared survival–growth studies and two from the survival-only studies. Growth used either a separate draw from the shared studies or the same draw as survival. Holding this mix fixed distinguished study-level coordination from changes in source coverage; it did not estimate within-colony or year-to-year survival–growth covariance. Each sensitivity retained 2,000 replicates, using seed 20261007.

Vardi [-@vardi2011] contributed survival data and the only fragmentation estimates, but no paired individual growth records to this matrix. With growth held unchanged and missing survival classes filled by the full-data estimates, lambda was 0.959 with all data, 0.954 when only Vardi’s survival data were removed, 0.892 when only its fragmentation estimates were removed, and 0.889 when both were removed. The combined exclusion therefore mainly reflected loss of fragmentation. SC5-to-SC5 stasis elasticity was 59.8%, with a 95% bootstrap interval of 37.9–71.9%; this local sensitivity does not estimate the effectiveness or cost of a restoration intervention.

\clearpage

## 10. Initial composition changed finite-horizon projections

**Table S4. Initial size composition affected the 50-year abundance threshold more than the choice of matrix-uncertainty representation.** Each row used all 2,000 valid bootstrap draws. Full-matrix simulations retained one complete bootstrap matrix for 50 years; lambda-only simulations retained the full-data matrix scaled by the corresponding bootstrap lambda. Effective lambda is exp[mean(log(*N*50 / *N*0))/50], where *N*t is total abundance at year *t*. The two percentage columns give fractions below 10% of initial abundance at year 50 without heatwaves and with observed Florida mortality recurring every 50 years. These are conditional simulation fractions, not full population-viability probabilities.

| Initial composition | Uncertainty | Baseline effective lambda | Below threshold, no heatwave (%) | Below threshold, 50-year heatwave (%) |
|:--------------------|:------------|----------------:|--------------------------------:|-------------------------------------:|
| Original | Lambda-only | 0.935 | 80.3 | 100.00 |
| Original | Full matrix | 0.935 | 78.0 | 100.00 |
| Recruit-heavy | Lambda-only | 0.923 | 91.9 | 100.00 |
| Recruit-heavy | Full matrix | 0.924 | 90.6 | 100.00 |
| Adult-heavy | Lambda-only | 0.971 | 23.4 | 99.85 |
| Adult-heavy | Full matrix | 0.971 | 24.0 | 99.75 |
| Stable | Lambda-only | 0.956 | 45.6 | 100.00 |
| Stable | Full matrix | 0.956 | 45.8 | 99.95 |

The original SC1–SC5 starting abundances were 100, 50, 30, 20, and 10 colonies. Recruit-heavy and adult-heavy starting proportions were 70, 15, 8, 5, and 2%, and 2, 3, 5, 20, and 70%, respectively; the stable composition was the full-data matrix’s dominant right eigenvector normalized to sum to one. All compositions were normalized to the same initial abundance. They were assumed starting structures, not measured regional population compositions.

Heatwave pulses followed the annual matrix transition and multiplied all classes by survival drawn uniformly from 0–2.2%, the reported bounds for the 2023 Florida endpoint [@manzello2025]. The same pulse draws were used across matrix methods and initial compositions, with seed 20261007 plus the scenario index. Full-matrix projections for the original composition gave effective lambdas of 0.358, 0.578, 0.771, and 0.849 for 5-, 10-, 20-, and 50-year recurrence, respectively. Every simulation was below the endpoint threshold at 5-, 10-, and 20-year recurrence, across all starting compositions and both uncertainty methods. At 50-year recurrence, the fractions ranged from 99.75 to 100%. Threshold attainment at any earlier time was recorded separately from the year-50 endpoint; the two measures agreed for baseline and observed-Florida scenarios, but not for every dose-response scenario. There was no sexual recruitment, immigration, density dependence, or environmental variation in annual matrix transitions.

## References
