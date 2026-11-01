---
title: "Online Resource 1: Supporting analyses for size-dependent demography, disturbance, and transition dynamics of *Acropora palmata* across the Caribbean"
author: "Adrian C. Stier; A. Raine Detmer; Karen L. Neely; Tali Vardi; Darcy Bradley; Aldo Croquer; Sergio D. Guendulain-García; Maria F. Villalpando; Rita I. Sellares-Blasco; Jameal F. Samhouri"
date: ""
bibliography:
  - paper/manuscript/references.bib
  - paper/manuscript/palmata_library.bib
  - paper/manuscript/disturbance_sources.bib
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
2. Regional screening windows overlapped most Tier 1 intervals (Tables S2 and S3)
3. Survival and relative growth varied with size (Fig. S1)
4. Study identity confounded population-origin comparisons (Fig. S2)
5. Surviving colonies often lost tissue and retrogressed (Fig. S3)
6. Size--survival associations varied among disturbance states (Fig. S4)
7. Observed survival varied among natural-fragment and restoration groups (Fig. S5)
8. Florida-scale heatwaves reduced recruitment-free projections (Fig. S6)
9. Resampling choices changed uncertainty more than the central estimate (Table S4)
10. Initial composition changed finite-horizon projections (Table S5)

**Study selection.** Consolidating duplicate and within-study entries reduced 104 screening-ledger rows to 101 distinct sources: 83 excluded and 18 included (seven individual-record studies and eleven summary studies). Seventeen studies supplied 22 survival-synthesis effects; Mendoza Quiroz et al. [-@mendozaquiroz2023] contributed only to size-dependent analyses. Approximately 2,500 records were identified, but inconsistent early screening totals prevent an exact PRISMA flow. The repository ledger retains all screening decisions.

\clearpage

## 1. Eighteen studies supported the synthesis

**Table S1. Eighteen studies contributed data; seventeen entered the survival synthesis.** Tier 1 studies supplied individual colony records; Tier 2 studies supplied study-level summaries. *N* is the effective annualized denominator in the survival synthesis after interval filtering and aggregation, summed across a study's effects; survival is the *N*-weighted mean of annualized effect-level survival and is shown for orientation only (Fig. 3 gives random-effects estimates). Roles: S, survival synthesis; V, size-dependent vital-rate models; M, transition matrix (natural-colony survival and growth). Fragmentation in the matrix came only from Vardi [-@vardi2011], whose summaries also entered the survival synthesis.

| Study | Tier | Region(s) | Population type | Effects | *N* | Survival (%) | Roles |
|:----------------------------|:--|:-------------------|:------------|---:|----:|-----:|:-------|
| NOAA monitoring | 1 | Florida Keys, Curaçao, Navassa | Natural | 3 | 3,874 | 87.4 | S, V, M |
| Neely et al. [-@neely2022] | 1 | Florida Keys | Natural | 1 | 2,643 | 75.0 | S, V, M |
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
| **Total** | | | | **22** | **9,059** | | |

The total denominator comprises 7,628 Tier 1 colony-interval records and 1,431
from Tier 2 effect-level sample sizes; it is not a count of unique colonies.
The full Tier 1 survival inventory contains 7,776 records, of which 52 Mendoza
Quiroz records, 2 loose-fragment intervals outside the consistent attached-colony protocol, and 94 NOAA
endpoint-selected fragment records did not enter these survival-synthesis effects.

**Source-record checks.** Main-text Methods define the area measurements and Neely live-area index. Twenty literal “live” entries establish survival with size unmeasured, not zero tissue; source identifiers preserve distinct rounds within calendar years. Collector verification removed all records for three colonies identified as another species and supplied 12 date-cell corrections, including confirmation of October 19, 2012 for Sombrero. All 2,645 Neely inventory records now have verified positive durations. The primary attached-colony cohort contains 2,643 records after withholding 2 loose-fragment intervals monitored only in the first round; both loose fragments died, and both remain visible in the inventory. Observed interval survival was 76.20% for the attached cohort and 76.14% when these two deaths were included; this descriptive sensitivity does not estimate an attachment effect. Every colony was wild. First-sighting AF codes identify a known natural-fragment cohort; branching, encrusting, and remnant forms were not treated as stable states or evidence of nonfragment origin. Only exact colony-ID matches were used: four extract IDs lacked type metadata but supplied no eligible interval pairs, while 28 metadata-only IDs created no demographic observations. AF records remain part of the existing Neely natural-colony effect, not an additional survival-synthesis effect. The correction and metadata-use audits retain the locators, unmatched IDs, and protocol exclusions. Known or suspected clonality limits the independent genetic information in colony counts.

**Reporting geography.** Florida Keys in the study table and Fig. 1 combines Florida reef-tract records, including Dry Tortugas; original site and region labels remain in the data. The 85.5% Florida Keys share in the main text uses the original Florida Keys label, before combining the additional Dry Tortugas observations for display.


**Size and reproductive status.** Soong and Lang [-@soonglang1992] reported a smallest fertile *A. palmata* colony of 16 × 8 cm and an operational puberty size of 1,600 cm² in Panama. Puberty size was the size of the smallest colony in the first group of 20 consecutively size-ranked colonies with at least 90% fertility. Their area estimate summed the living surface area of branches and the colony base; fertility meant gonads in sampled tissue, not observed spawning. These measurements are not directly interchangeable with the area measurements and live-area index pooled here. We therefore did not assign fertility to a model class or treat retrogression as loss of reproductive capacity. Neither reproductive output nor three-dimensional habitat complexity was estimated.

\clearpage

## 2. Regional screening windows overlapped most Tier 1 intervals

<!-- disturbance-catalogue:start -->
**Table S2. Eighteen author-assigned regional screening windows defined the disturbance comparison.** The table lists every entry used by the matching algorithm. Years are inclusive analysis windows, not necessarily independently observed onset and end dates. Duration, biological mechanism, and analytical role are separate: an extended event can be assigned to the acute-event sensitivity. SCTLD means stony coral tissue loss disease. No entry establishes exposure or cause of death in a matched colony.

| Event or contextual pressure | Matching region | Years | Duration; analytical role | Omit^a^ | Supporting sources |
|:--|:--|:--|:--|:--:|:--|
| Hurricane Hattie | Belize | 1961 | Acute; Acute-event screen | Yes | [@stoddart1963] |
| Historical white-band disease (coral disease) | Caribbean-wide | 1978–1984 | Chronic; Chronic regime | No | [@gladfelter1982; @aronsonprecht2001] |
| First *Diadema* die-off (indirect herbivory loss) | Caribbean-wide | 1983–1984 | Acute; Acute-event screen | Yes | [@lessios1984] |
| Hurricane Andrew | Florida Keys | 1992 | Acute; Acute-event screen | Yes | [@fonglirman1995; @lirman1997] |
| Cuevones Grounding | Mexico | 1997 | Acute; Acute-event screen | Yes | [@victoriasalazar2023] |
| Florida occupancy / water-quality context | Florida (Middle Keys) | 1999–2019 | Chronic; Chronic pressure | No | [@banister2024] |
| 2005 Hurricane Season | Florida Keys | 2005 | Acute; Acute-event screen | Yes | [@williamsmiller2012] |
| 2005 Thermal Anomaly | USVI/Florida | 2005–2006 | Chronic; Acute-event screen | Yes | [@eakin2010; @miller2009] |
| Recurring corallivorous-snail pressure | Florida Keys | 2005–2010 | Chronic; Biotic pressure | No | [@williamsmiller2012; @miller2001] |
| Playa Baracoa monitoring / water-quality context | Cuba | 2005–2021 | Chronic; Chronic pressure | No | [@ramos2024] |
| 2010 Cold-Water Event | Florida Keys | 2010 | Acute; Acute-event screen | Yes | [@lirman2011; @colella2012] |
| Recurring *Sargassum* pressure | Caribbean-wide | 2011–2025 | Annual; Chronic pressure | No | [@vantussenbroek2017; @antoniomartinez2020] |
| 2014–2017 global bleaching period | Caribbean-wide | 2014–2017 | Chronic; Chronic regime | No | [@eakin2019] |
| Hurricane Irma | FL Keys/USVI | 2017 | Acute; Acute-event screen | Yes | [@noaa2017irma; @noaa2018irmaassessment] |
| Noemi del Mar grounding (physical damage) | Puerto Rico | 2017 | Acute; Acute-event screen | Yes | [@noaa2017noemi] |
| SCTLD in other corals (indirect framework loss) | Mexico | 2018–2025 | Chronic; Indirect framework | No | [@alvarezfilip2022] |
| Second *Diadema* die-off (indirect herbivory loss) | USVI/Caribbean | 2022 | Acute; Acute-event screen | Yes | [@levitan2023] |
| 2023 Marine Heatwave | Caribbean-wide | 2023 | Acute; Acute-event screen | Yes | [@birkart2025; @manzello2025] |

^a^ Omit means that a matched observation interval was excluded from the acute-event sensitivity only; all intervals remained in the primary analyses. An interval matching several entries was flagged if any had Yes. Otherwise a match meant context-only pressure, and no match meant no curated overlap.

**How the windows were assigned.** These are screening conventions rather than a complete Caribbean disturbance history. The 1978–1984 white-band period combines historical accounts. The 2011–2025 *Sargassum* and 2018–2025 SCTLD screens extend reported pressures beyond the years directly observed in their cited studies. The 1999–2019 Florida water-quality window follows occupancy-record coverage, and the 2005–2021 Cuban window follows monitoring coverage; neither identifies uninterrupted pollution at every reef. Sources support the event or pressure, not every chosen boundary or exclusion decision. Unsupported quantitative intensity and impact claims in the original working catalogue are not used as evidence here.

**Geographic interpretation.** The matcher combined Florida Keys, Dry Tortugas, and Middle Keys labels as Florida, and local Mexican entries as Mexican Caribbean. Thus the local Cuevones grounding and Middle Keys water-quality context can match observations elsewhere in their broad reporting regions. Caribbean-wide entries match every represented region. The 2023 references document named Florida and Puerto Morelos losses, not uniform mortality throughout the Caribbean. *Diadema* die-offs and SCTLD in other corals describe indirect community changes, not diagnosed disease in *A. palmata*. Table S3 reports overlap with these choices; the three states cannot identify a causal disturbance effect.
<!-- disturbance-catalogue:end -->

\clearpage

**Table S3. Most monitoring windows matched the regional screening catalogue.** The summary links 1,007 monitoring-window groups from seven Tier 1 studies to the 18 entries in Table S2; these are grouped windows, not individual colony intervals. Only 35 groups (3.5%) had no catalogue match. "Baseline exclusion" identifies the 289 groups flagged for removal in the acute-event sensitivity analysis; it does not mean that other groups were undisturbed. These proportions describe overlap with the selected catalogue, not the fraction of colonies experiencing a measured disturbance.

| Study | Intervals | No overlap | One event | Two or more events | Baseline exclusion | Any overlap (%) |
|:--|--:|--:|--:|--:|--:|--:|
| NOAA monitoring | 776 | 35 | 49 | 692 | 220 | 95.5 |
| Neely et al. [-@neely2022] | 99 | 0 | 0 | 99 | 10 | 100.0 |
| Pausch et al. [-@pausch2018] | 70 | 0 | 0 | 70 | 46 | 100.0 |
| USGS outplant experiment | 27 | 0 | 15 | 12 | 12 | 100.0 |
| Kuffner et al. [-@kuffner2020] | 27 | 0 | 0 | 27 | 0 | 100.0 |
| Mendoza Quiroz et al. [-@mendozaquiroz2023] | 7 | 0 | 0 | 7 | 0 | 100.0 |
| FUNDEMAR fragments | 1 | 0 | 0 | 1 | 1 | 100.0 |
| **Total** | **1,007** | **35** | **64** | **908** | **289** | **96.5** |

**Matching rules.** Region labels were standardized (for example, Florida Keys and Dry Tortugas to Florida); entries naming several regions were expanded at slashes. Caribbean-wide entries applied to every represented region. If the starting survey year was $y$ and duration in years was $t$, the matching endpoint year was $\lfloor y+\max(t,1)-10^{-9}\rfloor$; missing or non-positive duration used one year for contextual matching only, never for annualizing survival. A match required inclusive calendar-year overlap and a matching region or Caribbean-wide entry. These rules can include a regionally documented pressure that was not measured at a particular reef.

**Worked classifications.** The 2005 thermal anomaly applied to Florida and the US Virgin Islands in 2005–2006: although its duration was labeled chronic, its analysis tier was acute-event and its exclusion flag was true. By contrast, Caribbean-wide 2014–2017 bleaching was chronic-regime context, with no baseline-exclusion flag; this does not mean bleaching was harmless. The 2018–2025 Mexican SCTLD entry described indirect loss of other framework species, not diagnosed SCTLD in *A. palmata*, and was not flagged for exclusion. White-band disease represented direct coral-disease history; *Diadema* die-offs represented indirect loss of herbivory. An interval with any true exclusion flag entered the acute category, one with overlap but no true flag entered context-only pressure, and one with no curated overlap entered no-curated-disturbance. Duration, biological mechanism, and analytical exclusion were separate fields.

The independent linkage check found no field mismatches; it verified execution of these rules, not individual exposure or cause of death. Table S2 gives the complete catalogue and its supporting sources. The repository retains the interval-by-entry assignments and diagnostics.

\clearpage

## 3. Survival and relative growth varied with size

**Fig. S1. Relative growth changed curvature at small sizes, whereas positive-growth probability had no supported nonlinear threshold.** (a) Survival against log colony area for natural colonies, excluding subannual intervals (*n* = 5,694); the generalized additive model (GAM) improved Akaike information criterion (AIC) over the linear model by 9.8 units (reporting gate: 2). (b) Probability of positive growth, for all colony sources (*n* = 5,065); the nonlinearity gate failed, so no threshold is marked. (c) Second derivative of the relative growth rate (RGR) GAM (*n* = 5,014); the dashed line marks the curvature minimum near 35 cm², not an outplant-size optimum. (d, e) Absolute areal growth rate (AGR, cm² yr^−1^; *n* = 5,065) and RGR (yr^−1^; *n* = 5,014) against colony size using their fitted records. (f) Within-bin standard deviations of AGR (cm² yr^−1^) and RGR (yr^−1^) on a logarithmic vertical axis (*n* = 5,902); lines join size-bin summaries and are directly labeled. The two growth measures have different units, so their standard deviations are not directly comparable in magnitude. Blue denotes survival or AGR; teal denotes positive growth or RGR. Points in a and b are binned proportions with approximate binomial 95% intervals; points in d and e are individual records. Solid curves are unadjusted GAM fits with pointwise 95% confidence ribbons; the dotted curve in a is the linear comparison. Growth responses use live-area change where available and total-area change otherwise; area includes the Neely index. Panel d and e axes display the central 98% of responses, while fits retain every fitted record. Primary growth fits exclude impossible values and proportional changes outside −50% to 200%; the variance display instead trims the extreme 0.5% tails and excludes high-variance Navassa records. The omitted lower-dimension positive-growth panel remains a repository diagnostic, not a second threshold estimate.

**Fig. S1 (continued)**

![](06_analysis/figures/supplementary/FigS1_growth_diagnostics.pdf){ width=174mm }

\clearpage

## 4. Study identity confounded population-origin comparisons

**Fig. S2. Natural-colony and restoration-origin comparisons are confounded by study identity and a narrow shared size range.** Each facet shows one Tier 1 study within the size range shared by natural and restoration records; restoration origin includes nursery-held material as well as outplants. (a) Observed survival and (b) relative growth rate (RGR, yr^−1^) against initial area (cm²), including the Neely live-area index where available. Points are observations, coloured lines are study-specific binomial generalized linear model (a) or linear model (b) fits on log size, shaded bands are 95% confidence intervals, and facet labels identify studies. For a study with all observed colonies surviving, the horizontal line marks the observed proportion; no survival slope or confidence band was estimated. The shared range (9–278 cm²) covers only a small part of the observed variation in colony area. Within it, survival slopes differed in sign among studies, so this comparison is descriptive rather than a causal estimate of restoration origin.

![](06_analysis/figures/supplementary/FigS8_natural_vs_restoration.pdf){ width=174mm }

\clearpage

## 5. Surviving colonies often lost tissue and retrogressed

**Fig. S3. Large colonies commonly survived while losing tissue, and every class above SC1 included transitions to smaller classes.** Tissue loss means any negative annual change in live area; shrinkage, or retrogression, means a transition to a smaller size class, following Vardi et al. [-@vardi2012]. (a) Tissue-loss frequency among surviving colonies by size class, rising from 23.1% in SC1 to 44.3% in SC5. (b) Mean annual tissue loss among colonies with negative area change (cm² yr^−1^). (c) Annualized transition probabilities: orange, movement to a larger class; gray, stasis; blue, retrogression. Labels give nonzero growth and retrogression percentages. In panel d, blue-to-orange point colour indicates increasing mean annual tissue loss; point area scales with record count. SC5 has no larger destination class. (d) Tissue-loss frequency by natural-colony study; point colour gives mean tissue loss and point size the number of records. All panels use the transition matrix's 4,808 natural-colony records from NOAA and Neely, with measured initial live area or live-area index (LAI), annual live-area change, and a positive observed live endpoint. Restoration records are excluded to keep this figure aligned with that natural-colony transition model; the separate descriptive restoration comparisons are in Fig. S5. Records were restricted to 0.5–1.5-year intervals, excluding impossible growth and the upper 1% of absolute live-area changes. Panel c projects one-year area from annualized change, with a 0.1 cm² floor, rather than observing every colony after exactly one year. SC1–SC5 starting counts were 39, 645, 1,423, 1,315, and 1,386.

![](06_analysis/figures/supplementary/FigS16_shrinkage_retrogression_summary.pdf){ width=174mm }

\clearpage

## 6. Size--survival associations varied among disturbance states

**Fig. S4. Observed demographic rates differ across curated disturbance states.** (a) Interval survival (*n* = 6,517) and (b) the fraction of records with positive growth (*n* = 5,460), for natural colonies across initial size classes and the three screening states defined in Methods. Blue shading encodes survival and orange positive-growth frequency; tile labels give percentages only where at least five records were available. White tiles have no observations and grey tiles have one to four; neither means a zero demographic rate. Per-cell counts remain in the companion summaries. The no-curated-overlap SC1 cell has one survival record and no growth records. This display threshold does not remove observations from summaries or models. Survival percentages average binary interval fates over differing survey durations, so they are not annual survival rates. The positive-growth indicator uses annual live-area change when available and total-area change otherwise; it is not restricted to the matched live endpoints used in the primary growth analysis. Study, site, size and time composition differ among states; these descriptive contrasts do not estimate causal disturbance effects or pairwise treatment differences.

![](06_analysis/figures/supplementary/FigS17_disturbance_size_interaction.pdf){ width=174mm }

\clearpage

## 7. Observed survival varied among natural-fragment and restoration groups

**Fig. S5. Natural-fragment and restoration groups have different sampling and handling histories.** (a) Observed interval survival and (b) relative live-area growth (yr^−1^) for the same eight groups. Open circles are study–region summaries, with point area proportional to record count; blue diamonds denote record-weighted survival and orange diamonds record-weighted growth, not population origin. Neither panel displays inferential intervals. The survival inventory contains 1,934 records: 94 naturally occurring NOAA fragments, 677 first-sighting naturally attached Neely fragments, 968 nursery outplants (Pausch), 53 block-mounted nursery fragments (Kuffner), 46 reef outplants of unspecified origin (USGS), 44 nursery-held fragments (FUNDEMAR), 35 sexually propagated reef outplants (Mendoza Quiroz), and 17 sexually propagated nursery juveniles (Mendoza Quiroz). NOAA fragment status was assigned among living endpoints; its survival point is withheld, not shown as starting-cohort survival. Neely AF status was recorded at first sighting and identifies a natural attached-fragment cohort followed subsequently. Branching, encrusting, and remnant first-sighting forms were not inferred to be nonfragments; late appearance or suspected clonality did not define AF status. The two first-round loose-fragment deaths are retained in the full inventory but belong to a different protocol and are not in this AF row. Thus 1,840 records support descriptive survival points; differing durations prevent reading them as standardized annual rates. Growth includes 1,271 measured live-area records from five studies, including 414 Neely AF intervals, with positive initial area, a positive observed endpoint, annual live-area change, and verified duration. No total-area substitution was made. Empty growth rows indicate unavailable measurements, not zero growth. Kuffner's nursery fragments were mounted on removable discs bolted to reef blocks, not reattached after post-planting breakage. Study, site, handling, size and observation history are unbalanced, so these groups cannot rank restoration practices.

![](06_analysis/figures/supplementary/FigS19_restoration_subtype_sensitivity.pdf){ width=174mm }

\clearpage

## 8. Florida-scale heatwaves reduced recruitment-free projections

**Fig. S6. Recurrence of Florida-scale heatwave mortality drives effective lambda far below one in the recruitment-free transition subsystem.** (a) Logistic mortality curve parameterized from the *A. palmata* DHW thresholds reported by Manzello et al. [-@manzello2025] (ED50 = 7.8 DHW; ED95 = 17.6 DHW); the shaded range marks the 16–20 DHW exposure in the Florida Keys in 2023. (b) Median 50-year trajectories and 95% simulation intervals without heatwaves and for the observed 2023 Florida endpoint (97.8–100% mortality) at four return intervals; the dashed line marks the quasi-extinction threshold of 10% of initial abundance. (c) Effective lambda across dose-response and observed-endpoint scenarios; bars are geometric means of annual abundance ratios from simulations that scale the fixed matrix structure by one bootstrap lambda per replicate, and the dotted line is the unperturbed deterministic lambda (0.955). Each scenario used 500 simulations. Grey denotes no added heatwave; sky blue, orange, vermilion and purple denote return intervals of 50, 20, 10 and 5 years, respectively, in both the trajectories and bars. Without heatwaves, effective lambda was 0.936 and 81.6% of simulations were below the quasi-extinction threshold at year 50; every observed-endpoint scenario was below that threshold at year 50 in all simulations. The 5-, 10-, 20-, and 50-year intervals span frequent to rare recurrence and are sensitivity values, not estimated return periods. The pooled reference includes monitoring through 2024, not a fitted pre-2023 counterfactual. These additional Florida-like pulses are stress tests, not historical reconstructions or Caribbean-wide forecasts.

![](06_analysis/figures/supplementary/FigS22_heatwave_scenarios.pdf){ width=174mm }

\clearpage

## 9. Resampling choices changed uncertainty more than the central estimate

**Table S4. Alternative resampling choices left lambda predominantly below replacement.** All analyses used the five-class recruitment-free matrix, annualized study-level survival pooling, near-annual natural-colony live-area transitions, and row-resampled annual fragmentation estimates. Transitions required both initial live area and annual live-area change; total-colony measurements were not substituted. Observed endpoints at or below zero were excluded from conditional growth, while deaths remained in the survival analysis. We projected one-year area by adding annual live-area change to initial live area and applying a 0.1 cm² floor. Intervals are 2.5th–97.5th bootstrap percentiles; the final column is the percentage of lambda estimates below one, not a probability of decline in a real population. *n* is the number of retained replicates. Analyses used R 4.5.2 and the project’s locked package versions.

| Resampling and missing-class treatment | *n* | Replicates imputed | 95% interval | Below one (%) |
|:--|--:|--:|:--|--:|
| Primary independent, point imputation | 2,000 | 135 | 0.913–1.000 | 97.5 |
| Primary independent, discard incomplete | 1,865 | 0 | 0.913–1.000 | 97.4 |
| Independent sensitivity, point imputation | 2,000 | 121 | 0.913–1.002 | 97.0 |
| Independent sensitivity, distribution imputation | 2,000 | 121 | 0.913–1.002 | 97.0 |
| Fixed study mix, independent | 2,000 | 0 | 0.917–1.001 | 97.3 |
| Fixed study mix, coordinated | 2,000 | 0 | 0.922–0.991 | 99.1 |

The primary bootstrap drew four survival studies and two growth studies independently, then resampled survival cells and colony growth records within each selected study. The independent sensitivity used a separate seed; within each replicate, point imputation and distribution imputation used identical survival, growth, and fragmentation draws. For a missing survival class, distribution imputation replaced its full-data point estimate with a survival draw from that class’s full-data bootstrap distribution. This propagated conditional sampling uncertainty, but did not supply evidence from an unobserved population.

For the fixed-study-mix comparison, both versions sampled two study instances from the two shared survival–growth studies and two from the survival-only studies. Growth used either a separate draw from the shared studies or the same draw as survival. Holding this mix fixed distinguished study-level coordination from changes in source coverage; it did not estimate within-colony or year-to-year survival–growth covariance. Each sensitivity retained 2,000 replicates, using seed 20261007.

Vardi [-@vardi2011] contributed survival data and the only fragmentation estimates, but no paired individual growth records to this matrix. With growth held unchanged and missing survival classes filled by the full-data estimates, lambda was 0.955 with all data, 0.952 when only Vardi’s survival data were removed, 0.890 when only its fragmentation estimates were removed, and 0.888 when both were removed. The combined exclusion therefore mainly reflected loss of fragmentation.

SC5-to-SC5 stasis accounted for 51.4% of matrix-cell elasticity (95% bootstrap interval: 38.8–64.5%). This means persistence in the largest live-area class strongly influenced the modeled rate; it does not estimate an intervention's effect. The primary independent-bootstrap interval ended just below replacement (upper limit 0.9999 before three-decimal rounding). Several alternative intervals included replacement; the separate imputation-sensitivity upper limit was 1.0021. Three-decimal rounding can obscure these small differences around one.

\clearpage

## 10. Initial composition changed finite-horizon projections

**Table S5. Initial size composition affected the 50-year abundance threshold more than the choice of matrix-uncertainty representation.** Each row used all 2,000 valid bootstrap draws. Full-matrix simulations retained one complete bootstrap matrix for 50 years; lambda-only simulations retained the full-data matrix scaled by the corresponding bootstrap lambda. Effective lambda is exp[mean(log(*N*50 / *N*0))/50], where *N*t is total abundance at year *t*. The two percentage columns give fractions below 10% of initial abundance at year 50 without heatwaves and with observed Florida mortality recurring every 50 years. These are conditional simulation fractions, not full population-viability probabilities.

| Initial composition | Uncertainty | Effective lambda, no heatwave | Below threshold, no heatwave (%) | Below threshold, 50-yr Florida pulse (%) |
|:--|:--|--:|--:|--:|
| Original | Lambda-only | 0.937 | 78.4 | 100.00 |
| Original | Full matrix | 0.937 | 77.5 | 100.00 |
| Small-colony-heavy | Lambda-only | 0.927 | 91.5 | 100.00 |
| Small-colony-heavy | Full matrix | 0.926 | 89.7 | 100.00 |
| Large-colony-heavy | Lambda-only | 0.973 | 20.0 | 99.95 |
| Large-colony-heavy | Full matrix | 0.973 | 21.1 | 99.95 |
| Stable | Lambda-only | 0.956 | 47.2 | 100.00 |
| Stable | Full matrix | 0.956 | 47.5 | 100.00 |

The original SC1–SC5 starting abundances were 100, 50, 30, 20, and 10 colonies. Small-colony-heavy proportions were 70, 15, 8, 5, and 2%; large-colony-heavy proportions were their exact reverse, 2, 5, 8, 15, and 70%. The stable composition was the full-data matrix’s dominant right eigenvector normalized to sum to one. All compositions were normalized to the same initial abundance. These assumptions bracket contrasting size structures, not measured regional compositions or verified ages or maturity states.

Heatwave pulses followed the annual matrix transition and multiplied all classes by survival drawn uniformly from 0–2.2%, the reported bounds for the 2023 Florida endpoint [@manzello2025]. The same pulse draws were used across matrix methods and initial compositions, with seed 20261007 plus the scenario index. Full-matrix projections for the original composition gave effective lambdas of 0.358, 0.578, 0.772, and 0.852 for 5-, 10-, 20-, and 50-year recurrence, respectively. At least 99.85% of simulations were below the endpoint threshold at 5-, 10-, 20-, and 50-year recurrence across all starting compositions and both uncertainty methods; the only fractions below 100% occurred with the large-colony-heavy composition at 50-year recurrence. Threshold attainment at any earlier time was recorded separately from the year-50 endpoint; the two measures agreed for baseline and observed-Florida scenarios, but not for every dose-response scenario. There was no sexual recruitment, immigration, density dependence, or environmental variation in annual matrix transitions.

## References
