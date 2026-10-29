---
title: "Online Resource 1: Supporting analyses for size-dependent demography, disturbance, and transition dynamics of *Acropora palmata* across the Caribbean"
author: "Adrian C. Stier; A. Raine Detmer; Karen L. Neely; Tali Vardi; Darcy Bradley; Aldo Croquer; Sergio D. Guendulain-García; Maria F. Villalpando; Rita I. Sellares-Blasco; Jameal F. Samhouri"
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
3. Survival and relative growth varied with size (Fig. S1)
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
| Neely et al. [-@neely2022] | 1 | Florida Keys | Natural | 1 | 2,625 | 74.8 | S, V, M |
| Pausch et al. [-@pausch2018] | 1 | Florida Keys | Restoration | 1 | 968 | 57.4 | S, V |
| Kuffner et al. [-@kuffner2020] | 1 | Florida Keys | Restoration | 1 | 53 | 81.1 | S, V |
| USGS outplant experiment (unpublished) | 1 | US Virgin Islands | Restoration | 1 | 46 | 65.5 | S, V |
| FUNDEMAR fragments (unpublished) | 1 | Dominican Republic | Nursery-held fragments | 1 | 44 | 86.6 | S, V |
| Mendoza Quiroz et al. [-@mendozaquiroz2023] | 1 | Mexican Caribbean | Sexual nursery and reef cohorts | -- | -- | -- | V |
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
| **Total** | | | | **22** | **9,041** | | |

The total denominator comprises 7,610 Tier 1 colony-interval records and 1,431
from Tier 2 effect-level sample sizes; it is not a count of unique colonies.
The prepared Tier 1 survival file contains 7,780 records, of which 52 Mendoza
Quiroz records, 24 Neely records without usable interval duration, and 94 NOAA
endpoint-selected fragment records did not enter these survival-synthesis effects.

**Neely measurement and date conventions.** LAI was $[(L+W+H)/3]^2\times p_{\mathrm{live}}$, a live-area index based on three colony dimensions and live-tissue proportion, not a traced planar area. The source contains 20 literal “live” entries, meaning alive with LAI unmeasured; these were preserved as known fates, never zeros. Growth required measured LAI at both endpoints. Source interval identifiers preserved distinct survey rounds within a calendar year. Of 2,649 prepared Neely survival records, 24 could not be annualized because at least one survey-date cell was blank in the original worksheet. These occurred at DT1, MR3, SR2, and SR3; no missing dates were recoverable by correcting parsing, and none were inferred from neighboring colonies. The repository's `neely_missing_duration_audit.csv` lists colony, source row, both date-cell addresses, and inclusion disposition. Known fates without sufficient starting-size or date information remain in the source inventory rather than being assigned fabricated sizes or annual rates.

Equal LAI values may represent a small intact colony, a tissue remnant, or several isolates on an older skeleton. Colonies at Dry Tortugas and Marker 3 were known to be clonal, with clonality suspected elsewhere. Observations therefore represent colony intervals, not independent genotypes or reproductive states. Site and year effects can coincide with disturbance: the Marker 3 population collapsed during 2014 bleaching across colony sizes.

**Size and reproductive status.** Soong and Lang [-@soonglang1992] reported a smallest fertile *A. palmata* colony of 16 × 8 cm and an operational puberty size of 1,600 cm² in Panama. Puberty size was the size of the smallest colony in the first group of 20 consecutively size-ranked colonies with at least 90% fertility. Their area estimate summed the living surface area of branches and the colony base; fertility meant gonads in sampled tissue, not observed spawning. These measurements are not directly interchangeable with the area measurements and live-area index pooled here. We therefore did not assign fertility to a model class or treat retrogression as loss of reproductive capacity. Neither reproductive output nor three-dimensional habitat complexity was estimated.

\clearpage

## 2. Disturbance exposure was pervasive in Tier 1 intervals

**Table S2. Curated disturbance overlap was pervasive across the demographic records.** The study-window summary links 1,075 monitoring-window groups from the seven Tier 1 studies to the curated disturbance timeline; these are grouped windows, not individual colony intervals. Only 53 groups (4.9%) overlapped no curated event. "Baseline exclusion" identifies the 297 groups flagged for removal in the acute-event sensitivity analysis; it does not mean that other groups were undisturbed.

| Study | Intervals | No overlap | One event | Two or more events | Baseline exclusion | Any overlap (%) |
|:--|--:|--:|--:|--:|--:|--:|
| NOAA monitoring | 842 | 50 | 59 | 733 | 228 | 94.1 |
| Neely et al. [-@neely2022] | 101 | 3 | 0 | 98 | 10 | 97.0 |
| Pausch et al. [-@pausch2018] | 70 | 0 | 0 | 70 | 46 | 100.0 |
| USGS outplant experiment | 27 | 0 | 15 | 12 | 12 | 100.0 |
| Kuffner et al. [-@kuffner2020] | 27 | 0 | 0 | 27 | 0 | 100.0 |
| Mendoza Quiroz et al. [-@mendozaquiroz2023] | 7 | 0 | 0 | 7 | 0 | 100.0 |
| FUNDEMAR fragments | 1 | 0 | 0 | 1 | 1 | 100.0 |
| **Total** | **1,075** | **53** | **74** | **948** | **297** | **95.1** |

**Matching rules.** Region labels were standardized (for example, Florida Keys and Dry Tortugas to Florida); entries naming several regions were expanded at slashes. Caribbean-wide entries applied to every represented region. If the starting survey year was $y$ and duration in years was $t$, the matching endpoint year was $\lfloor y+\max(t,1)-10^{-9}\rfloor$; missing or non-positive duration used one year for contextual matching only, never for annualizing survival. A match required inclusive calendar-year overlap and a matching region or Caribbean-wide entry. These rules can include a regionally documented pressure that was not measured at a particular reef.

**Worked classifications.** The 2005 thermal anomaly applied to Florida and the US Virgin Islands in 2005–2006: although its duration was labeled chronic, its analysis tier was acute-event and its exclusion flag was true. By contrast, Caribbean-wide 2014–2017 bleaching was chronic-regime context, with no baseline-exclusion flag; this does not mean bleaching was harmless. The 2018–2025 Mexican SCTLD entry described indirect loss of other framework species, not diagnosed SCTLD in *A. palmata*, and was not flagged for exclusion. White-band disease represented direct coral-disease history; *Diadema* die-offs represented indirect loss of herbivory. An interval with any true exclusion flag entered the acute category, one with overlap but no true flag entered context-only pressure, and one with no curated overlap entered no-curated-disturbance. Duration, biological mechanism, and analytical exclusion were separate fields.

The independent linkage check found no field mismatches; it verified execution of these rules, not individual exposure or cause of death. The complete chronology, source citations, interval assignments, and diagnostics remain in the repository.

\clearpage

## 3. Survival and relative growth varied with size

**Fig. S1. Relative growth changed curvature at small sizes, whereas positive-growth probability had no supported nonlinear threshold.** (a) Survival against log colony area for natural colonies, excluding subannual intervals (*n* = 5,711); the generalized additive model (GAM) improved AIC over the linear model by 9.2 units (reporting gate: 2). (b) Probability of positive growth, for all colony sources (*n* = 5,048); the nonlinearity gate failed, so no threshold is marked. (c) Second derivative of the RGR GAM (*n* = 4,997); the dashed line marks the curvature minimum near 35 cm², not an outplant-size optimum. (d, e) AGR (*n* = 5,048) and RGR (*n* = 4,997) against colony size using their fitted records. (f) Standard deviation within size bins on a log scale (*n* = 5,884); lines join bin summaries and are directly labeled. Blue denotes survival or AGR; teal denotes positive growth or RGR. Points in a and b are binned proportions with approximate binomial 95% intervals; points in d and e are individual records. Solid curves are unadjusted GAM fits with pointwise 95% confidence ribbons; the dotted curve in a is the linear comparison. Growth responses use live-area change where available and total-area change otherwise; area includes the Neely index. Panel d and e axes display the central 98% of responses, while fits retain every fitted record. Primary growth fits exclude impossible values and proportional changes outside −50% to 200%; the variance display instead trims the extreme 0.5% tails and excludes high-variance Navassa records. The omitted lower-dimension positive-growth panel remains a repository diagnostic, not a second threshold estimate.

**Fig. S1 (continued)**

![](06_analysis/figures/supplementary/FigS1_growth_diagnostics.pdf){ width=174mm }

\clearpage

## 4. Study identity confounded population-origin comparisons

**Fig. S2. Natural-colony and restoration-origin comparisons are confounded by study identity and a narrow shared size range.** Each facet shows one Tier 1 study within the size range shared by natural and restoration records; restoration origin includes nursery-held material as well as outplants. (a) Observed survival and (b) relative growth rate (yr^−1^) against initial area (cm²), including the Neely live-area index where available. Points are observations, coloured lines are study-specific binomial GLM (a) or linear model (b) fits on log size, shaded bands are 95% confidence intervals, and labels give population type and sample size. The shared range (9–278 cm²) covers only a small part of the observed variation in colony area. Within it, survival slopes differed in sign among studies, so this comparison is descriptive rather than a causal estimate of restoration origin.

![](06_analysis/figures/supplementary/FigS8_natural_vs_restoration.pdf){ width=174mm }

\clearpage

## 5. Surviving colonies often lost tissue and retrogressed

**Fig. S3. Large colonies commonly survived while losing tissue, and every class above SC1 included transitions to smaller classes.** Tissue loss means any negative annual change in live area; shrinkage, or retrogression, means a transition to a smaller size class, following Vardi et al. [-@vardi2012]. (a) Tissue-loss frequency among surviving colonies by size class, rising from 22.5% in SC1 to 44.2% in SC5. (b) Mean annual tissue loss among colonies with negative area change (cm² yr^−1^). (c) Annualized transition probabilities: dark blue, movement to a larger class; slate gray, stasis; orange, retrogression. Labels give retrogression probabilities. (d) Tissue-loss frequency by study; point colour gives mean tissue loss and point size the number of records. All panels use the same 4,698 natural-colony records from NOAA and Neely, with measured initial live area or LAI, annual live-area change, and a positive observed live endpoint; no restoration-fragment records enter this figure. Records were restricted to 0.5–1.5-year intervals, excluding impossible growth and the upper 1% of absolute live-area changes. Panel c projects one-year area from annualized change, with a 0.1 cm² floor, rather than observing every colony after exactly one year. SC1–SC5 starting counts were 40, 637, 1,375, 1,269, and 1,377.

![](06_analysis/figures/supplementary/FigS16_shrinkage_retrogression_summary.pdf){ width=174mm }

\clearpage

## 6. Size--survival associations varied among disturbance states

**Fig. S4. Size associations differed among curated exposure states, without identifying causal disturbance effects.** Tiles show (a) observed interval survival (*n* = 6,523 natural-colony records) and (b) the proportion with positive reported areal growth (*n* = 5,346), by starting size class and exposure state. Labels give percentages and cell counts; blue encodes survival and gold positive growth. Both panels display percentages only for cells with at least five records. Gray “<5 obs.” tiles indicate sparse observations; white “No data” tiles indicate none. The no-curated-disturbance SC1 cell contains one survival record and no growth records. This display rule does not exclude records from the models or summary tables. The global size-by-state interaction had likelihood-ratio *p* = 0.001 for survival and *p* = 0.005 for positive growth; these are not pairwise tests of the displayed class-specific contrasts. Models included a study random intercept. The exposure states follow section 2, and remain confounded with study, site, and survey period. Growth uses live-area change where available and total-area change otherwise, unlike the strict live-area subset in Fig. S3.

![](06_analysis/figures/supplementary/FigS17_disturbance_size_interaction.pdf){ width=174mm }

\clearpage

## 7. Restoration estimates varied among colony-source subtypes

**Fig. S5. Colony source and observation setting define different descriptive comparisons.** (a) Observed interval survival and (b) mean relative live-area growth (yr^−1^). Open circles are study–region summaries with point area proportional to records; filled diamonds, offset above each row, are record-weighted subtype means. Neither panel shows uncertainty bars because the available studies cannot establish comparable between-program uncertainty. The survival inventory comprises 1,257 records from six studies: 968 Pausch nursery outplants, 94 naturally occurring NOAA fragments, 53 re-cemented Kuffner outplants, 46 USGS outplants of unspecified origin, 44 FUNDEMAR nursery-held fragments, and 35 reef plus 17 nursery juveniles of sexual origin from Mendoza Quiroz. NOAA fragment status was assigned among living endpoints, so its apparent 100% survival is withheld, not presented as cohort survival. The remaining 1,163 records support descriptive interval-survival points; differing interval durations prevent reading these as standardized annual rates. Growth includes 857 records from four studies, requiring measured initial live area and annual live-area change, positive duration, and a positive observed endpoint, without total-area substitution. Kuffner and Mendoza Quiroz lack the required live-change field; unavailable growth is labeled, not zero. Source, study, site, handling, and sample size are unbalanced, so these summaries cannot rank restoration practices.

![](06_analysis/figures/supplementary/FigS19_restoration_subtype_sensitivity.pdf){ width=174mm }

\clearpage

## 8. Florida-scale heatwaves reduced recruitment-free projections

**Fig. S6. Recurrence of Florida-scale heatwave mortality drives effective lambda far below one in the recruitment-free transition subsystem.** (a) Logistic mortality curve parameterized from the *A. palmata* DHW thresholds reported by Manzello et al. [-@manzello2025] (ED50 = 7.8 DHW; ED95 = 17.6 DHW); the shaded range marks the 16–20 DHW exposure in the Florida Keys in 2023. (b) Median 50-year trajectories and 95% simulation intervals without heatwaves and for the observed 2023 Florida endpoint (97.8–100% mortality) at four return intervals; the dashed line marks the quasi-extinction threshold of 10% of initial abundance. (c) Effective lambda across dose-response and observed-endpoint scenarios; bars are geometric means of annual abundance ratios from simulations that scale the fixed matrix structure by one bootstrap lambda per replicate, and the dotted line is the unperturbed deterministic lambda (0.955). Each scenario used 500 simulations. Without heatwaves, effective lambda was 0.938 and 81.0% of simulations were below the quasi-extinction threshold at year 50; every observed-endpoint scenario was below that threshold at year 50 in all simulations. The 5-, 10-, 20-, and 50-year intervals span frequent to rare recurrence and are sensitivity values, not estimated return periods. The pooled reference includes monitoring through 2024, not a fitted pre-2023 counterfactual. These additional Florida-like pulses are stress tests, not historical reconstructions or Caribbean-wide forecasts.

![](06_analysis/figures/supplementary/FigS22_heatwave_scenarios.pdf){ width=174mm }

\clearpage

## 9. Resampling choices changed uncertainty more than the central estimate

**Table S3. Alternative resampling choices left lambda predominantly below replacement.** All analyses used the five-class recruitment-free matrix, annualized study-level survival pooling, near-annual natural-colony live-area transitions, and row-resampled annual fragmentation estimates. Transitions required both initial live area and annual live-area change; total-colony measurements were not substituted. Observed endpoints at or below zero were excluded from conditional growth, while deaths remained in the survival analysis. We projected one-year area by adding annual live-area change to initial live area and applying a 0.1 cm² floor. Intervals are 2.5th–97.5th bootstrap percentiles; the final column is the percentage of lambda estimates below one, not a probability of decline in a real population. *n* is the number of retained replicates. Analyses used R 4.5.2 and the project’s locked package versions.

| Resampling and missing-class treatment | *n* | Replicates imputed | 95% interval | Below one (%) |
|:--------------------------------------|----:|--------:|:-------------|--------------:|
| Primary independent, point imputation | 2,000 | 151 | 0.916–0.998 | 98.0 |
| Primary independent, discard incomplete | 1,849 | 0 | 0.915–0.997 | 98.1 |
| Independent sensitivity, point imputation | 2,000 | 131 | 0.915–1.000 | 97.4 |
| Independent sensitivity, distribution imputation | 2,000 | 131 | 0.915–1.000 | 97.4 |
| Fixed study mix, independent | 2,000 | 0 | 0.916–0.998 | 97.7 |
| Fixed study mix, coordinated | 2,000 | 0 | 0.924–0.993 | 98.9 |

The primary bootstrap drew four survival studies and two growth studies independently, then resampled survival cells and colony growth records within each selected study. The independent sensitivity used a separate seed; within each replicate, point imputation and distribution imputation used identical survival, growth, and fragmentation draws. For a missing survival class, distribution imputation replaced its full-data point estimate with a survival draw from that class’s full-data bootstrap distribution. This propagated conditional sampling uncertainty, but did not supply evidence from an unobserved population.

For the fixed-study-mix comparison, both versions sampled two study instances from the two shared survival–growth studies and two from the survival-only studies. Growth used either a separate draw from the shared studies or the same draw as survival. Holding this mix fixed distinguished study-level coordination from changes in source coverage; it did not estimate within-colony or year-to-year survival–growth covariance. Each sensitivity retained 2,000 replicates, using seed 20261007.

Vardi [-@vardi2011] contributed survival data and the only fragmentation estimates, but no paired individual growth records to this matrix. With growth held unchanged and missing survival classes filled by the full-data estimates, lambda was 0.955 with all data, 0.953 when only Vardi’s survival data were removed, 0.890 when only its fragmentation estimates were removed, and 0.888 when both were removed. The combined exclusion therefore mainly reflected loss of fragmentation.

SC5-to-SC5 stasis accounted for 51.4% of matrix-cell elasticity (95% bootstrap interval: 38.8–64.5%). This means persistence in the largest live-area class strongly influenced the modeled rate; it does not estimate an intervention's effect. The independent imputation-sensitivity interval had an unrounded upper bound of 1.0004, just above replacement despite rounding to 1.000 in Table S3.

\clearpage

## 10. Initial composition changed finite-horizon projections

**Table S4. Initial size composition affected the 50-year abundance threshold more than the choice of matrix-uncertainty representation.** Each row used all 2,000 valid bootstrap draws. Full-matrix simulations retained one complete bootstrap matrix for 50 years; lambda-only simulations retained the full-data matrix scaled by the corresponding bootstrap lambda. Effective lambda is exp[mean(log(*N*50 / *N*0))/50], where *N*t is total abundance at year *t*. The two percentage columns give fractions below 10% of initial abundance at year 50 without heatwaves and with observed Florida mortality recurring every 50 years. These are conditional simulation fractions, not full population-viability probabilities.

| Initial composition | Uncertainty | Baseline effective lambda | Below threshold, no heatwave (%) | Below threshold, 50-year heatwave (%) |
|:--------------------|:------------|----------------:|--------------------------------:|-------------------------------------:|
| Original | Lambda-only | 0.938 | 79.6 | 100.00 |
| Original | Full matrix | 0.938 | 78.3 | 100.00 |
| Small-colony-heavy | Lambda-only | 0.927 | 91.7 | 100.00 |
| Small-colony-heavy | Full matrix | 0.927 | 90.0 | 100.00 |
| Large-colony-heavy | Lambda-only | 0.974 | 18.0 | 99.95 |
| Large-colony-heavy | Full matrix | 0.973 | 19.5 | 99.90 |
| Stable | Lambda-only | 0.957 | 46.7 | 100.00 |
| Stable | Full matrix | 0.957 | 47.2 | 100.00 |

The original SC1–SC5 starting abundances were 100, 50, 30, 20, and 10 colonies. Small-colony-heavy proportions were 70, 15, 8, 5, and 2%; large-colony-heavy proportions were their exact reverse, 2, 5, 8, 15, and 70%. The stable composition was the full-data matrix’s dominant right eigenvector normalized to sum to one. All compositions were normalized to the same initial abundance. These assumptions bracket contrasting size structures, not measured regional compositions or verified ages or maturity states.

Heatwave pulses followed the annual matrix transition and multiplied all classes by survival drawn uniformly from 0–2.2%, the reported bounds for the 2023 Florida endpoint [@manzello2025]. The same pulse draws were used across matrix methods and initial compositions, with seed 20261007 plus the scenario index. Full-matrix projections for the original composition gave effective lambdas of 0.359, 0.580, 0.773, and 0.851 for 5-, 10-, 20-, and 50-year recurrence, respectively. At least 99.9% of simulations were below the endpoint threshold at 5-, 10-, 20-, and 50-year recurrence across all starting compositions and both uncertainty methods; the only fractions below 100% occurred with the large-colony-heavy composition at 50-year recurrence. Threshold attainment at any earlier time was recorded separately from the year-50 endpoint; the two measures agreed for baseline and observed-Florida scenarios, but not for every dose-response scenario. There was no sexual recruitment, immigration, density dependence, or environmental variation in annual matrix transitions.

## References
