---
title: "Size-dependent demography, disturbance, and transition dynamics of *Acropora palmata* across the Caribbean"
article_type: "Report"
target_journal: "Coral Reefs"
status: "Complete first manuscript draft; citations and submission metadata require final verification"
bibliography:
  - manuscript/references.bib
  - manuscript/palmata_library.bib
link-citations: true
header-includes:
  - \usepackage{pdflscape}
---

Adrian C. Stier^1,2,^*, A. Raine Detmer^1^, Karen L. Neely^7,8^, Tali Vardi^9^, Darcy Bradley^4^, Aldo Croquer^5^, Rita I. Sellares-Blasco^6^, and Jameal F. Samhouri^3^

^1^ Department of Ecology, Evolution, and Marine Biology, University of California, Santa Barbara, California, USA  
^2^ Marine Science Institute, University of California, Santa Barbara, CA 93106, USA  
^3^ Conservation Biology Division, Northwest Fisheries Science Center, National Marine Fisheries Service, National Oceanic and Atmospheric Administration, Seattle, Washington, USA  
^4^ California Oceans Program, The Nature Conservancy, Sacramento, California, USA  
^5^ The Nature Conservancy, Caribbean Division, Punta Cana, Dominican Republic  
^6^ Fundación Dominicana de Estudios Marinos (FUNDEMAR), Bayahibe, Dominican Republic  
^7^ Halmos College of Natural Sciences and Oceanography, Nova Southeastern University, Dania Beach, Florida, USA\
^8^ Florida Fish and Wildlife Research Institute, St. Petersburg and Marathon, Florida, USA\
^9^ Scripps Institution of Oceanography, University of California San Diego, La Jolla, California, USA\
^*^ Correspondence: Adrian C. Stier

Corresponding author email: astier@ucsb.edu

## Abstract

Restoration and conservation of endangered corals require understanding the demographic processes that maintain populations and replace lost colonies. For the reef-building elkhorn coral *Acropora palmata*, survival alone does not reveal whether colonies retain live tissue and remain large enough to sustain reef habitat. We compiled longitudinal observations from 18 Caribbean studies and separated survival, growth, tissue loss, and movement among five size classes. Annual survival increased with colony size, but surviving colonies often lost tissue or moved into smaller classes. In a recruitment-free transition model that included fragmentation, persistence of the largest colonies contributed most to population growth; the deterministic $\lambda$ was 0.959, below replacement but close to it. Restoration records did not support a single survival rate for all colony sources: estimates differed among natural fragments, nursery outplants, re-cemented nursery outplants, and direct outplants. Simulated mortality matching the 2023 Florida heatwave further reduced effective $\lambda$ to 0.849 even when events recurred only once every 50 years. Restoration monitoring should therefore follow live area and size-class transitions alongside survival to assess whether colonies reach and remain in the adult classes that sustain reef habitat.

Keywords: Caribbean coral reefs; demographic synthesis; elkhorn coral; meta-analysis; population dynamics; restoration

## Introduction

The decline of endangered reef-building corals creates an immediate conservation problem: restoring colony abundance may do little to replace the habitat lost when large colonies die. Caribbean acroporid declines have reduced coral cover and the habitat once provided by *Acropora palmata* [@aronsonprecht2001; @gardner2003]. White-band disease, storms, predation, and chronic tissue loss continue to alter the abundance and condition of remaining colonies [@gladfelter1982; @rogersmuller2012; @williamsmiller2012]. Restoration programs now propagate and outplant *A. palmata*, but assessing their contribution to recovery requires knowing whether these colonies survive, grow, and retain live tissue long enough to replace large adults [@edmundsriegl2020]. The demographic rates needed to make that assessment remain scattered among studies and regions.

Colony size links individual performance to population persistence. Small corals can grow rapidly in proportional terms but experience high mortality, whereas large colonies can survive, reproduce, and produce fragments [@hughes1984; @hughesjackson1985; @highsmith1982; @lirman2000; @madin2014]. However, survival does not ensure continued growth toward adult size. Storm damage, disease, and predation can remove live tissue from surviving colonies, and sufficient tissue loss moves a colony into a smaller size class [@lirman1997; @madin2020]. Partial mortality can also reduce reproductive output: *A. palmata* colonies with unhealed lesions produced smaller eggs than apparently healthy colonies, and the lesions did not regenerate over four months [@pinongonzalez2018]. Thus, two populations with similar survival could differ in their ability to maintain large colonies if survivors differ in growth and tissue loss. Size-structured models connect these processes by tracking both colony survival and movement among size classes.

Disturbance changes the conditions under which these demographic rates are measured. Storm frequency and intensity alter population trajectories in stage-structured simulations [@lirman2003], while field monitoring and larval experiments show that disturbance can affect different life stages through different pathways [@rogersmuller2012; @randall2009]. Disease outbreaks can also cluster within local populations, complicating comparisons among sites [@lentz2011]. Excluding disturbed intervals would restrict a synthesis to the subset of conditions that remain after storms, disease, bleaching, and chronic pressures are removed. Yet pooling all intervals without retaining their exposure histories would obscure whether differences among studies reflect colony size or the conditions experienced during monitoring. The 2023 marine heatwave, which caused functional extinction of *A. palmata* in Florida [@manzello2025], makes this distinction consequential: rates estimated before the event cannot establish persistence under heatwaves of similar magnitude.

Colony source further complicates comparisons among restoration studies. Nursery outplants, colonies re-cemented after fragmentation, direct outplants, and natural fragments differ in initial size, handling, and environment [@forrester2012; @ramosromero2025; @banister2024]. Early survival and later outplant performance can also respond to different processes [@williams2008; @williams2023]. Pooling these colonies as “restoration fragments” combines demographic records from different starting conditions and treatments. A pooled survival estimate may consequently describe the mixture of colony sources represented in the data more than the performance of any particular restoration practice. Comparing studies requires retaining colony source alongside size and disturbance history.

The widely used size-structured model for *A. palmata* was parameterized from tagged colonies in the northern Florida Keys [@vardi2012], but the extent to which its rates represent colonies elsewhere in the Caribbean remains uncertain. Here, we combined individual colony records from seven studies with summaries from eleven additional studies to estimate size-dependent survival and growth. We then quantified tissue loss, movement to smaller size classes, and variation associated with disturbance history and colony source. Finally, we used a five-class transition model based on Vardi et al. [-@vardi2012] to connect these rates to annual population change, retaining fragmentation and fixing sexual recruitment at zero. We expected that survival and growth would vary with colony size, that size–survival relationships would differ among disturbance categories, and that persistence of large adults would contribute most to the model's growth rate. This synthesis evaluates how the available demographic evidence informs the maintenance and replacement of large colonies, while identifying where source coverage limits that inference.

## Materials and methods

### Literature search and study selection

From June through December 2025, we searched repositories maintained by NOAA and the US Geological Survey, structured Google Scholar results, backward and forward citations from focal demographic studies, and data shared by restoration practitioners. In March 2026, we expanded the search through PubMed, Web of Science, Semantic Scholar/Elicit, targeted citation searches, and the project literature library. Search terms combined *Acropora palmata* or elkhorn coral with survival, mortality, growth, recruitment, restoration, and long-term monitoring. Additional individual colony records were obtained by direct data sharing in April 2026. The repository archives the search strings, screening decisions, and study-level exclusions.

We included studies that reported longitudinal observations of identified *A. palmata* colonies or fragments, survival or areal growth over a defined interval, and sufficient information to annualize survival or estimate a size-dependent vital rate. We excluded cross-sectional condition surveys, studies that reported only branch extension, laboratory micro-fragment experiments smaller than 1 cm², and overlapping analyses of the same tagged-colony datasets. Titles and abstracts were screened first, followed by full-text evaluation. A second reviewer independently evaluated a subset of expanded-search candidates; disagreements underwent a third review. Across all sources, we identified approximately 2,500 records, assessed 101 distinct study or data sources at full text or repository level, and excluded 83 with documented reasons; the most common reasons were a different species, overlap with an included dataset, and cross-sectional designs. The screening ledger contained 104 rows; we consolidated one duplicate Gladfelter record and three Vardi entries representing the same underlying study. When a source supplied an eligible parameter but another parameter was excluded, we counted the study once as included.

The final dataset comprised 18 studies. Seven supplied individual colony records: NOAA long-term monitoring of tagged colonies in the Florida Keys, Curaçao, and Navassa; Neely et al. [-@neely2022]; Pausch et al. [-@pausch2018]; Kuffner et al. [-@kuffner2020]; a USGS outplant experiment in the US Virgin Islands; FUNDEMAR nursery fragments in the Dominican Republic; and Mendoza Quiroz et al. [-@mendozaquiroz2023]. Eleven supplied study-level summaries [@rogers1982; @bruckner2001; @ortizprosper2005; @garrison2008; @williamsmiller2010; @vardi2011; @rogersmuller2012; @forrester2013; @maurer2022; @rosales2024; @ramosromero2025]. Seventeen of these studies, contributing 22 study-region effects, entered the survival synthesis. Mendoza Quiroz et al. [-@mendozaquiroz2023] contributed only to the size-dependent analyses (Online Resource 1, Table S1).

### Data extraction and standardization

We classified records into two tiers. Tier 1 studies supplied individual colony identifiers, repeated sizes, and survival fates; these records supported analyses of survival, growth, shrinkage, and size-class transitions. Tier 2 studies supplied study-level survival proportions, sample sizes, and, where available, mean colony size. The raw survival file contained 7,842 interval records. We removed 480 duplicate records identified by study, colony identifier, survey year, and location, followed by 16 records with missing survival or missing or non-positive size, leaving 7,346 prepared records. The raw growth file contained 6,318 records; removing 423 duplicates left 5,895 prepared records. These counts describe colony intervals, which can include repeated observations of the same colony.

We standardized colony size as live planar tissue area in cm². For records containing perpendicular dimensions and live-tissue proportion, we calculated area as length × width × proportion live tissue, following the convention used in previous *A. palmata* size-structured matrix models [@vardi2012]. For diameter-only records, we estimated area from a circular footprint. Where a study reported a single linear measure, we applied study-informed width-to-length ratios; records for which size could not be defensibly converted were retained for survival synthesis but not size-dependent analyses. We annualized non-annual survival as $S_{\mathrm{annual}} = S_{\mathrm{observed}}^{1/t}$, where $t$ is the monitoring interval in years. This transformation assumes a constant hazard within each interval and therefore does not represent seasonal mortality peaks. Mortality definitions also differed among studies, from loss of both tissue and skeleton in NOAA monitoring to loss of at least half of live tissue in Kuffner et al. [-@kuffner2020]. We retained each study's definition rather than imposing a common one, so part of the among-study variation reflects measurement rather than biology. Because demographic observations alone cannot identify the sexual versus clonal origin of colonies, genetic information would also be needed to evaluate the origins of colonies contributing to population persistence [@groberdunsmore2007].

We assigned colonies to five size classes: SC1, 0 < area ≤ 10 cm²; SC2, 10 < area ≤ 100 cm²; SC3, 100 < area ≤ 900 cm²; SC4, 900 < area ≤ 4,000 cm²; and SC5, area > 4,000 cm². These boundaries retain the structure of the published *A. palmata* Lefkovitch model while separating recruits from small juveniles [@vardi2011]. We used shrinkage for a negative annual change in live tissue area within a colony that survived the interval, and retrogression for movement into a smaller size class. A colony could shrink without retrogressing, or retrogress after enough tissue loss to cross a class boundary. Stasis meant survival in the same size class, which could occur despite tissue loss.

We calculated relative growth rate as $\mathrm{RGR} = G/A_0$, where $G$ is annual areal change (cm² yr^−1^) and $A_0$ is initial colony area (cm²), giving RGR in yr^−1^. We used live-tissue area and live-tissue change where available, with total-colony measurements as fallbacks. Negative RGR indicates a decrease in measured area; positive RGR indicates an increase.

### Disturbance and restoration classification

We included disturbed intervals in the primary analyses to describe colonies under the conditions they experienced. We linked each interval to a Caribbean timeline of storms, disease, bleaching, cold events, and chronic pressures. The timeline distinguished intervals with no documented exposure, chronic or indirect pressure only, and an acute event. We removed the acute-event intervals in a sensitivity analysis; the absence of a documented event did not establish that an interval was undisturbed. An independent check verified the interval-to-event assignments (Online Resource 1, Table S2). We tested whether size--survival relationships differed among these categories using natural colonies only, excluding restoration handling and material from that comparison.

For restoration analyses, we used study metadata to classify records as natural fragments, nursery outplants, nursery outplants re-cemented after fragmentation, or outplanted colonies. We compared subtype-specific survival to assess how pooling distinct colony sources affected the broad "restoration fragment" estimate. Because studies differed in colony source and site, these comparisons did not estimate intervention effects.

### Statistical analyses

We fitted binomial generalized additive models (GAMs) for annual survival and Gaussian GAMs for relative growth, using log-transformed colony size as the predictor. Fig. 2 shows fits to pooled observations without adjustment for study; mixed-effect models accounting for study tested sensitivity to pooling. Following the pre-specified threshold procedure of Detmer et al. [-@detmer2025], we first compared each GAM with a linear model. We reported a threshold only if the GAM improved AICc by at least 2 units, then used derivatives of the fitted curve to locate it. We checked model fit and repeated the analyses with each study excluded in turn to assess how much the estimated threshold depended on study composition.

For the survival synthesis, we aggregated annualized survival proportions into study-region effects. For Tier 1 data, we estimated survival within groups sharing study, region, population type, and interval duration, annualized those proportions, and averaged them within effects using the number of interval records as weights. This synthesis used 7,176 of the prepared records: 52 Mendoza Quiroz records were outside the survival-synthesis study set, 24 Neely records lacked usable interval duration, and 94 NOAA restoration-fragment records were excluded from the natural-colony NOAA effects. Tier 2 effects contributed a further denominator of 1,431, giving 8,607 across 22 effects. Within the hand-extracted Tier 2 summaries, we used the maximum initial sample size within each effect rather than summing repeated census denominators, and weighted annualized survival by initial sample size. The total denominator therefore combines Tier 1 colony-interval records and Tier 2 effect-level sample sizes; it is not a count of unique colonies.

We transformed those proportions to log-odds effect sizes and applied a 0.5 continuity correction to zero cells. The primary random-effects model was a three-level REML model with study and within-study effect structure and *t*-based inference; an independent-effect model with Knapp–Hartung inference was a sensitivity analysis [@knapp2003; @viechtbauer2010]. We report pooled survival, 95% confidence intervals, prediction intervals, and heterogeneity statistics. We evaluated population type, colony size, year, and region as exploratory moderators because the number of effects was limited. We also performed leave-one-out, classification, and risk-of-bias sensitivity analyses. We assessed small-study effects with Egger-type regression tests on the independent-effect and three-level models and with trim-and-fill on the independent-effect model. Funnel-plot methods were designed for comparative effect sizes, so we treat these tests as diagnostics of asymmetry among single-proportion effects rather than as direct tests of publication bias.

We constructed a five-class Lefkovitch matrix to describe annual changes in the abundance of natural colonies. The matrix included survival, growth, movement to smaller classes, and fragment production; sexual recruitment was fixed at zero. Its dominant eigenvalue ($\lambda$) therefore described annual growth of this recruitment-free model, not growth of the full population. Four studies contributed survival rates and two contributed growth rates. NOAA records supplied most SC5 size-class survival observations, and Vardi [-@vardi2011] supplied the only fragmentation estimates. We calculated matrix-cell elasticities: the proportional change in $\lambda$ expected from a small proportional change in each cell, with other cells held constant. To propagate sampling uncertainty, we resampled studies, then observations within sampled studies. We retained 2,000 valid bootstrap replicates; 132 imputed survival for at least one missing size class. The bootstrap did not propagate survival–growth covariance. We also excluded each of the four contributing studies in turn, refitting the same survival estimator and growth transitions. Excluding Vardi also removed its fragmentation estimates; missing survival classes used the full-data estimates.

To test whether independent survival and growth resampling affected uncertainty, we compared two additional 2,000-replicate bootstraps. Both retained two draws from the studies shared by survival and growth and two from survival-only studies; the coordinated version used the same shared-study draws for survival and growth. This comparison tested study-level coordination while holding the study mix fixed, but could not estimate temporal survival–growth covariance. We also replaced missing-class survival with a draw from its full-data bootstrap distribution, compared this with point imputation and discarding incomplete replicates, and removed Vardi’s survival and fragmentation contributions separately (Online Resource 1, Table S3).

We treated the 2023 Florida heatwave as an episodic, Florida-specific survival pulse rather than as a replacement for the chronic-regime matrix. We first used the *A. palmata* dose-response thresholds reported by Manzello et al. [-@manzello2025] (ED50 = 7.8 degree-heating weeks [DHW], ED95 = 17.6 DHW) to define 8-, 12-, and 18-DHW sensitivity scenarios. We then added an observed-2023 Florida endpoint: 97.8--100% mortality, represented by a 0--2.2% heatwave-year survival multiplier. The deterministic projection used the midpoint of that range; because the published study reports bounds rather than a colony-level sampling distribution, Monte Carlo projections sampled uniformly across the reported range at each prescribed event. Each of 500 simulations per scenario retained the full-data matrix structure, scaled by one sampled bootstrap lambda for all 50 years; these simulations propagated parameter uncertainty, not environmental variation in annual transition rates. Heatwave pulses were applied after the annual matrix transition to all size classes, consistent with the reported absence of size refuge during the Florida event. We report the geometric mean of annual abundance ratios as effective lambda under recurrence intervals of 5, 10, 20, and 50 years, and the fraction of simulations in which total abundance fell below 10% of its initial value at year 50 (quasi-extinction). We prescribed these recurrence intervals to compare frequent and rare events; we did not estimate future return periods. The projections describe the recruitment-free subsystem under Florida-like mortality and cannot estimate Caribbean-wide thermal mortality or full population viability.

To test sensitivity to matrix structure and initial size composition, we projected all 2,000 complete bootstrap matrices and compared these with matrices scaled by the corresponding bootstrap lambdas. Each matrix remained fixed for 50 years, and heatwave mortality draws were identical across paired comparisons. The original starting population contained 100, 50, 30, 20, and 10 colonies in SC1–SC5; alternative starting proportions were 70, 15, 8, 5, and 2% (recruit-heavy), 2, 3, 5, 20, and 70% (adult-heavy), and the full-data matrix’s stable size distribution. These compositions were sensitivity assumptions, not estimates of Caribbean population structure (Online Resource 1, Table S4).

### Reproducibility

We conducted analyses in R 4.5.2 under the project’s locked computational environment; the central workflow uses `mgcv` for generalized additive models, `metafor` for meta-analysis, and `lme4` for mixed-effect diagnostic models. The public repository contains the data-processing and analysis scripts, figures, and tables, with links from each main-text result to its generating script and output (Data availability statement below). A versioned archival release will be deposited upon acceptance.

## Results

### Evidence spanned the Caribbean but remained geographically uneven

Demographic records covered 13 Caribbean regions, but the Florida Keys supplied 6,222 observations (84.7% of the 7,346 prepared individual-level survival records), more than all other regions combined (Fig. 1). Several regions contributed records from only a subset of size classes. Records of large adults were concentrated in Florida, Curaçao, and Navassa, leaving their survival and transitions poorly documented elsewhere.

### Survival and growth increased nonlinearly with colony size

Annual survival increased from roughly 60% below 10 cm² to above 90% beyond 4,000 cm², although colony size explained less than 10% of the deviance in individual fate (Fig. 2a). The survival GAM fit better than a linear model (ΔAICc = 17.9), with an estimated inflection near 7,498 cm²; that location varied widely when individual studies were excluded. Relative growth changed most sharply near 37 cm², whereas the threshold for the probability of positive growth occurred near 411 cm² (Online Resource 1, Fig. S1). Absolute-growth variance increased strongly with size, while relative growth described size dependence more effectively.

Study-level survival estimates by size class showed that the size effect was concentrated in the largest classes (Fig. 2c). Pooled survival was nearly flat from SC1 to SC3 (77.3%, 75.1%, and 76.6%) and then rose to 90.9% in SC4 and 94.7% in SC5, where every study estimate exceeded 82%. Among-study spread was widest in SC1–SC3, where individual estimates ranged from about 40% to 100% and where study context, disturbance history, and population type varied most strongly. Colony size alone did not account for the wide variation among studies.

### Annual survival varied widely among Caribbean studies

The expanded synthesis estimated pooled annual survival at 78.7% (95% CI: 70.4--85.1%; 95% prediction interval: 37.4--95.8%) across 17 studies and 22 study-region effects (Fig. 3a). Tier 1 and Tier 2 effects were both annualized before aggregation. Heterogeneity was high (I² = 97.6%; $\tau^2$ = 0.72, of which 0.29 was between studies and 0.44 within studies), so the pooled value summarizes the assembled evidence rather than a Caribbean-wide constant. No single study moved the independent-effect estimate by more than 2.6 percentage points in leave-one-out analyses, and restricting the synthesis to the 13 studies with the highest methodological-quality scores changed it by less than 1 point. Evidence for small-study asymmetry was mixed: the Egger-type test was not significant for the independent-effect model (*p* = 0.55) but was significant for the three-level model (*p* = 0.001), and trim-and-fill imputed three effects and lowered the independent-effect estimate from 80.1% to 77.3%.

Pooled survival was 85.4% for natural-colony effects (95% CI 72.9–92.7%, *k* = 10) and 74.5% for restoration-fragment effects (95% CI 63.9–82.9%, *k* = 12). Population type was not a supported moderator (*p* = 0.20), but this result did not establish equivalent survival. With 22 effects, the minimum detectable difference at 80% power was about 20 percentage points, larger than the observed 10.9-point difference. Regional variation remained substantial within population types (Fig. 3b). Even where the two types overlapped in colony size, study identity and sampling context could not be separated from population origin (Online Resource 1, Fig. S2).

### Surviving colonies often shrank and moved into smaller size classes

Surviving colonies lost live tissue in 39.4% of records used for the transition analysis (Online Resource 1, Fig. S3). Shrinkage frequency increased from 18.2% in SC1 to 47.5% in SC5. Among non-recruit classes, the probabilities of moving to a smaller class were 15.2% in SC2, 16.8% in SC3, 17.2% in SC4, and 9.1% in SC5. Higher survival in large colonies therefore coexisted with frequent tissue loss and occasional movement out of the largest class.

### Size--survival associations differed across exposure categories

Of 1,072 monitoring intervals, 95.1% overlapped a documented disturbance or chronic pressure (Online Resource 1, Table S2). Among 6,141 natural-colony survival records, only 353 came from intervals with no documented exposure, including 193 SC5 records. Size--survival relationships differed among the three exposure categories (likelihood-ratio test, *p* < 0.001; Online Resource 1, Fig. S4). Large colonies survived more often during intervals with acute events (SC5: 98.0%, *n* = 409; SC4: 90.4%, *n* = 250) than during intervals with no documented exposure (SC5: 83.9%, *n* = 193; SC4: 79.1%, *n* = 91). Survival in SC2 and SC3 differed by less than 6 percentage points among categories. The size-by-exposure interaction was weaker for positive growth (*p* = 0.010). Removing acute-event intervals from the individual-level synthesis (six studies) changed pooled survival only from 75.9% to 75.6%. These comparisons describe study intervals with different exposure histories; they do not isolate mortality caused by the events.

### Restoration survival varied among colony-source subtypes

The subtype-coded dataset contained 5,079 records from five studies (Online Resource 1, Fig. S5): 3,968 natural fragments from one study, 1,012 nursery outplants from two studies, 53 re-cemented nursery outplants from one study, and 46 direct outplants from one study. Natural fragments had weighted survival of 87.1%, compared with 58.7% for nursery outplants, 81.1% for nursery outplants re-cemented after fragmentation, and 65.2% for outplanted colonies. Excluding natural fragments reduced mean survival across subtype-coded records from 81.2% to 60.0%. The subtype estimates describe highly unbalanced groups from different studies and do not isolate effects of colony source.

### Large-adult stasis dominated conditional transition dynamics

The recruitment-free transition matrix estimated a deterministic lambda of 0.959 (95% bootstrap interval: 0.902–1.001; Fig. 4). In 97.1% of hierarchical-bootstrap replicates, lambda was below one. This resampling fraction characterizes uncertainty in the compiled transition rates; it is not a probability of real-world population decline. Stasis dominated the transition matrix, and SC5-to-SC5 stasis accounted for 59.8% of matrix-cell elasticity (95% bootstrap interval: 37.9–71.9%). Leave-one-study-out estimates of lambda ranged from 0.889 (excluding Vardi [-@vardi2011], including its fragmentation estimates) to 0.977 (excluding Neely et al. [-@neely2022]). Excluding NOAA monitoring lowered lambda to 0.936. These exclusions used the same survival estimator and transition filters as the primary matrix. Removing fragmentation altogether lowered lambda to 0.892, so asexual fragment production, estimated from a single study, contributed about 0.07 to the deterministic growth rate. Within this conditional, recruitment-free subsystem, persistence of large adults had more influence on lambda than marginal changes in any single early transition.

Coordinating the shared-study draws widened the uncertainty slightly: 95.6% of lambda estimates were below one (95% interval: 0.891–1.005), compared with 97.5% under independent resampling with the same study mix (Online Resource 1, Table S3). Lambda was below one in 96.9% of the 2,000 replicates under both point and distribution-based missing-class imputation. Removing Vardi’s survival data alone lowered lambda to 0.954, whereas removing its fragmentation estimates alone lowered it to 0.892. The combined exclusion effect therefore arose mainly from fragment production.

### Florida-scale heatwaves reduced effective lambda

Adding heatwave mortality reduced projected abundance without changing the underlying chronic-regime matrix. Under the observed 2023 Florida endpoint, effective lambda was 0.355, 0.576, 0.768, and 0.849 when a Florida-like event recurred every 5, 10, 20, and 50 years, respectively (Online Resource 1, Fig. S6). In these primary simulations, every observed-endpoint scenario was below the quasi-extinction threshold at year 50 in all 500 simulations. Without heatwaves, 78.4% of the 500 primary simulations were below the year-50 threshold, and effective lambda was 0.935. This finite-horizon rate differed from the deterministic eigenvalue of 0.959 because it included bootstrap uncertainty and transient changes in size structure. The 18-DHW dose-response sensitivity scenario was less severe than the observed endpoint because its fitted mortality was 95.5%, rather than the 97.8--100% mortality reported from the Florida Keys and Dry Tortugas. In these recruitment-free projections, recurrence of the observed Florida mortality drove abundance below the quasi-extinction threshold even at the longest return interval. The scenarios do not forecast recovery across the Caribbean.

Complete-matrix uncertainty gave similar baseline projections for the original size composition: effective lambda was 0.935 and 78.0% of simulations fell below 10% of initial abundance at year 50 (Online Resource 1, Table S4). In the paired comparison using all 2,000 bootstrap draws, 80.3% of lambda-only simulations were below the year-50 threshold. Initial size composition had a larger effect: with full matrices and no heatwaves, the fraction below the threshold ranged from 24.0% for adult-heavy populations to 90.6% for recruit-heavy populations. Under observed Florida mortality recurring every 50 years, 99.75–100% were below the threshold across the four starting compositions; shorter return intervals placed every simulation below it.

## Discussion

Rebuilding the habitat provided by *A. palmata* requires both maintaining large colonies and producing colonies that will replace them. Our synthesis suggests that these objectives are closely linked by tissue loss: large colonies survived more often, but survivors frequently shrank and sometimes moved into smaller size classes. Persistence in the largest class contributed most to population growth in the recruitment-free matrix. Consequently, colony survival alone can overstate progress toward maintaining adult colonies if survivors lose enough tissue to leave that class.

### Colony size connects survival to persistence

The demographic contribution of a surviving colony depends on the size it retains. Size-structured theory captures this distinction by separating survival from growth and movement to smaller classes [@hughes1984; @hughesjackson1985]. In our matrix, large-colony stasis had the greatest elasticity, agreeing with the northern Florida Keys model of Vardi et al. [-@vardi2012] and with Lirman's [-@lirman2000] observations of persistence, reproduction, and fragment production in large *A. palmata* colonies. Agreement with Vardi is partly expected because Florida Keys monitoring also dominates our largest-size-class data. The synthesis adds evidence that remaining alive does not ensure remaining large: tissue loss occurred in 47.5% of SC5 growth records, and 9.1% of surviving colonies moved out of SC5. Disease and corallivore stress on large colonies in St. John [@groberdunsmore2006] provide a further reason to distinguish whole-colony mortality from partial loss of live tissue. Protecting an adult colony's demographic contribution therefore requires retaining its live area as well as preventing its death.

Growth and survival changed over different size ranges, making a single size threshold an incomplete basis for choosing outplants. Relative growth changed most sharply near 37 cm², whereas survival increased across a much larger range of sizes. A size associated with rapid proportional growth need not confer high survival, and neither fitted relationship establishes the size at which an outplant will reach adulthood. The survival inflection also shifted when individual studies were excluded, limiting its use as a planting rule. Initial-size trials should therefore follow cohorts through successive size classes and compare the proportion that reaches and remains in adult classes. That comparison would connect a choice of planting size to adult replacement more directly than survival measured over one interval.

### Disturbance and the limits of pooled rates

Demographic rates measured under one disturbance regime may fail to describe persistence under another. Storm-driven population simulations [@lirman2003] illustrate why the frequency of mortality events matters in addition to demographic performance between events. In our observational comparison, large colonies survived more often during intervals flagged for acute disturbance, but exposure was confounded with study, site, and survey period. Intervals without a documented event were few and came from a narrow set of studies and years. The comparison therefore cannot establish that disturbance benefited colonies or estimate the mortality caused by an event. Manzello et al. [-@manzello2025] provide a more direct measure of event mortality: 97.8–100% of *A. palmata* died in the Florida Keys and Dry Tortugas during the 2023 heatwave. Applying that mortality to our matrix further reduced effective $\lambda$ even when events recurred only once every 50 years. High survival before such an event offers little assurance that large adults will persist through its recurrence.

Geographic coverage and differences in measurement also limit the transfer of pooled rates to a particular restoration site. The annual-survival prediction interval spanned 37.4–95.8%, and Florida Keys studies supplied 84.7% of prepared individual-level survival records. Colonies outside Florida, especially large adults, were poorly represented; studies also differed in mortality definitions and monitoring intervals. Coordinated resampling and alternative treatments of missing size classes retained an estimate close to replacement, although the coordinated interval (0.891–1.005) included both decline and growth. The separate Vardi exclusions showed that fragment production contributed more to the change in $\lambda$ than removal of its survival observations. Thus, uncertainty reflects both the demographic observations and which processes particular studies supplied. The pooled matrix provides a comparison for local monitoring, but its rates require evaluation against the colony sizes, disturbance history, and mortality definitions at the site where they will be used.

### Restoration should maintain and replace adult colonies

Comparing restoration practices requires separating the effect of a treatment from the colonies and sites selected for that treatment. Our subtype comparison could not make that separation. Natural fragments supplied most records and came from one study; removing them reduced record-weighted survival from 81.2% to 60.0%. The other sources differed in initial size, nursery history, attachment, substrate, and site. These differences matter because genotype, habitat, and size jointly shaped outplant performance in Pausch et al. [-@pausch2018], while Kuffner et al. [-@kuffner2020] documented recovery through restoration at particular sites. The subtype estimates consequently provide no basis for ranking colony sources across programs. For example, evaluating re-cementation would require comparing broken colonies with and without re-cementation at comparable sites, then measuring whether attachment changes survival, tissue retention, and subsequent growth.

Monitoring can make these treatment comparisons more informative by following the fate of the original cohort. Each cohort should retain records of colony source, initial live planar area, attachment treatment, site, and survey interval. Repeated surveys should record death and classify survivors as advancing, remaining in the same size class, or moving to a smaller class; live-area measurements would also identify tissue loss that does not cross a class boundary. Deaths and the fraction reaching and remaining in adult classes should be reported relative to the original cohort, alongside growth and tissue loss among survivors. Reporting both would prevent high growth among a few survivors from obscuring losses from the cohort. First-year benchmarks for established *Acropora cervicornis* outplants [@schopmeyer2017] and the early bottlenecks reported during sexual propagation of *A. palmata* [@chamberland2015; @mendozaquiroz2023] concern different species, origins, and stages. Their use in restoration comparisons requires preserving those distinctions and matching the follow-up interval.

Adult protection and production of new colonies address different parts of the replacement process. The high elasticity of adult stasis identifies a transition to test with interventions that reduce death or tissue loss; it does not establish their effectiveness or their return per unit cost. Small outplants could supply future adults, but their contribution depends on survival and growth through the intervening classes. Trials of disease response, locally justified corallivore management, or stabilization after damage should therefore measure adult tissue retention and size-class persistence, while trials of size at outplanting should measure the fraction of planted colonies that eventually enters adult classes. Sexual propagation also involves processes outside our matrix. Red algae, macroalgae, and cyanobacteria can alter settlement or larval survival [@ritsonwilliams2013; @ritsonwilliams2020], so substrate and early-life-stage trials are needed to connect sexual recruitment to subsequent adult replacement. Our analysis cannot rank these interventions without estimates of treatment effects and costs.

By reporting adult attainment relative to the planted cohort and tissue retention among existing adults, restoration programs can identify where losses interrupt replacement [@madin2025]. A treatment that improves early survival but leaves few colonies reaching adult classes addresses a different limitation from one that prevents tissue loss in established adults. Evaluating those outcomes separately would connect restoration actions to their contribution to maintaining reef-building colonies.

## Acknowledgements

We thank the NOAA Southeast Fisheries Science Center, the US Geological Survey, and FUNDEMAR for sharing monitoring data, and the authors of the published studies whose summaries made this synthesis possible.

## Statements and Declarations

### Funding

This work was supported by The Nature Conservancy.

### Competing interests

The authors declare no competing interests.

### Ethics approval and permits

Not applicable. This study synthesized existing observations and published
study summaries and involved no new human-participant research, animal use, or
field collection requiring ethical approval or permits.

### Consent to participate

Not applicable.

### Consent to publish

Not applicable.

### Data availability

The data and code underlying this study are maintained at
<https://github.com/stier-lab/rse-2025-detmer-apalmata-rse-parameters>. A versioned
archival release will be deposited upon acceptance.

### Author contributions

A.C.S. conceived the study and led manuscript development. A.R.D. led data
curation and analyses, made the figures, and contributed to manuscript review. K.L.N. contributed Florida Keys data, data
interpretation, and manuscript review. T.V. contributed the transition-matrix
framework, fragmentation estimates, and interpretation. J.F.S., D.B., A.C.,
and R.I.S.-B. contributed domain expertise, data resources, and interpretation.

## Online resources

**Online Resource 1 (ESM_1.pdf).** Concise supporting analyses for the *Acropora palmata* demographic synthesis: four supporting tables, including study coverage, disturbance overlap, matrix resampling, and projection sensitivities, and six supplementary figures. Extended diagnostics and source outputs remain available in the public repository.

## Figure legends

```{=latex}
\footnotesize
```

**Fig. 1** Study locations and size-class coverage for the *Acropora palmata* demographic synthesis. (a) Study locations across the Caribbean. Circles identify individual-level (Tier 1) studies and triangles summary-level (Tier 2) studies; regions with both are shown with both symbols. Symbol area is proportional to the number of observations, and labels give regional totals. Locations are regional centroids. (b) Availability of individual-level observations by size class and region; cell labels are sample sizes, and darker cells indicate more observations. Empty cells indicate no available observations. Size classes are SC1, 0–10 cm²; SC2, 10–100 cm²; SC3, 100–900 cm²; SC4, 900–4,000 cm²; and SC5, >4,000 cm². Each class includes its upper boundary and excludes its lower boundary; zero-area records were excluded.

**Fig. 2** Size-dependent demographic rates for *Acropora palmata*. (a) Annual survival probability as a function of live tissue area for natural colonies. The line and shaded band are an unadjusted binomial generalized additive model (GAM) and its 95% confidence interval; points are binned observed proportions. Upper and lower rugs identify survival and mortality observations, respectively. (b) Relative growth rate (yr^−1^) for natural colonies. The line and band are the unadjusted Gaussian GAM estimate and 95% confidence interval; pale points are individual observations, gold points are binned medians, and the dashed vertical line and band show the supported threshold and its cluster-bootstrap interval. (c) Study-level annual survival by size class. Colour indicates population type, shape identifies data tier, and point area is proportional to sample size; diamonds and error bars are pooled estimates and 95% confidence intervals. *k* gives the number of contributing effects.

**Fig. 3** Caribbean-wide survival synthesis for *Acropora palmata*. (a) Random-effects annual-survival estimates from 17 studies contributing 22 effects. Points and horizontal lines are study estimates and 95% confidence intervals; point area is proportional to random-effects weight. Circles represent individual-level data and triangles summary-level data. Coloured diamonds are population-type pooled estimates, the dark diamond is the overall pooled estimate, the dashed line marks that estimate, and the shaded interval is its 95% prediction interval. (b) Regional study estimates and 95% confidence intervals. Colour identifies population type, point area is proportional to sample size, and dark diamonds identify regional pooled estimates where at least two effects were available. The dashed line marks overall pooled annual survival.

**Fig. 4** Conditional transition dynamics for *Acropora palmata*. (a) Five-class, recruitment-free Lefkovitch transition matrix. Cells give annual matrix entries from size class at time *t* to size class at time *t* + 1; colour encodes entry magnitude. Entries combine survival and size-class movement with fragment production in the SC5 column, which consequently sums to more than one [@vardi2011]. (b) Elasticity decomposition by source size class. Stacked bars show stasis, growth, and retrogression; orange points show fragmentation elasticity, which is displayed separately because it is included in the retrogression entries rather than an additional transition class. (c) Distribution of lambda from 2,000 hierarchical-bootstrap replicates. Gray bars denote replicates with lambda < 1 and green bars replicates with lambda at least 1; the distribution characterizes uncertainty in the compiled transition rates, not the probability of real-world decline. The dashed line is the deterministic estimate and the solid line marks replacement. (d) Leave-one-study-out lambda estimates. The dashed and dotted lines mark the full-data estimate and replacement, respectively; orange identifies exclusion of the NOAA survey.

```{=latex}
\normalsize
\clearpage
```

## Figures

![](06_analysis/figures/manuscript/Fig1_study_landscape.pdf){ width=160mm }

**Figure 1. Study locations and size-class coverage for the *Acropora palmata* demographic synthesis.**

\clearpage


![](06_analysis/figures/manuscript/Fig2_demographic_rates.pdf){ width=160mm }

**Figure 2. Size-dependent survival and growth rates for *Acropora palmata*.**

\clearpage


![](06_analysis/figures/manuscript/Fig3_caribbean_synthesis.pdf){ width=160mm }

**Figure 3. Caribbean-wide annual-survival synthesis for *Acropora palmata*.**

\clearpage


![](06_analysis/figures/manuscript/Fig4_population_model.pdf){ width=160mm }

**Figure 4. Conditional recruitment-free transition dynamics for *Acropora palmata*.**

```{=latex}
\clearpage
```

## References {#refs}
