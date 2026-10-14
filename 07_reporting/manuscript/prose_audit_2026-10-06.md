# Manuscript prose audit — 6 October 2026

Scope: canonical main manuscript, abstract, declarations, and figure captions. Initial editorial passes included an independent style review; a complementary pass addressed sentence logic and paragraph handoffs. This is a prose-quality audit, not a determination of authorship.

## Changes

- Replaced the awkward urgency opener with a direct statement of habitat loss, adult persistence, and the demographic information restoration lacks.
- Removed repeated rhetorical contrasts, contribution advertising, and broad closing claims. For example, “central limitation and central contribution” now gives the survival prediction interval and explains why it cannot serve as a local target.
- Replaced “demographic leverage,” “study landscape,” and internal workflow shorthand with elasticity, study locations, and explicit comparisons.
- Cut the unsupported comparison between deployment counts and recovery. The abstract now recommends tracking live area and transitions alongside survival.
- Clarified that the 39.4% shrinkage estimate describes growth records from survivors, not a count of unique surviving colonies.
- Made restoration recommendations specific to comparison cohorts, initial size, follow-up, tissue retention, and transitions. Explicitly stated that the synthesis did not estimate treatment effectiveness or costs.
- Replaced threshold-based intervention claims with a bounded interpretation: fitted inflections do not establish safe planting sizes or optimal treatment sizes.
- Removed a duplicated annualization equation while retaining its definition and constant-hazard assumption.
- Corrected the Mendoza description to size-dependent analyses, consistent with its V-only role in Table S1 and the natural-colony matrix.
- Corrected the data-availability link to the repository's current GitHub name.
- Removed the unfilled ORCID line and editorial acknowledgement prompt from the paper. Removed the blanket coauthor-approval assertion because approval must be confirmed before submission.

## Preserved

The analysis, numerical results, figure files, cited studies, author order, funding, and competing-interest declaration were not changed. Technical terms such as elasticity, retrogression, and recruitment-free were retained. Qualifications about study imbalance, observational disturbance categories, bootstrap uncertainty, and the Florida-specific heatwave scenarios remain explicit.

## Author follow-up

Confirm optional ORCID identifiers, any additional named acknowledgements, and approval by all coauthors before submission. Missing information was not invented or silently represented as verified.

## Complementary pass

- Shortened the abstract without removing results from the Results section.
- Defined stasis explicitly and distinguished size-class retention from tissue retention. Growth, shrinkage, and stasis are not mutually exclusive measurements.
- Replaced compressed disturbance-category labels with descriptions of documented exposure.
- Explained matrix elasticity and the recruitment-free model boundary in Methods.
- Separated disturbance and restoration material discussions so their evidence and recommendations are not conflated.
- Distinguished an unsupported population-type moderator from evidence of equivalent survival.
- Specified original-cohort denominators for recommended monitoring summaries.
- Paired figure paragraphs with their following captions in the Word export.

## Separate result inconsistency found during page review

Figure 4's PDF and PNG report lambda = 0.959, interval 0.902–1.001, 97.1% of bootstrap replicates below one, and SC5 stasis elasticity 59.8%. The main text reports lambda = 0.961, interval 0.816–1.010, 94.3%, and 58.9%, respectively. Leave-one-study-out labels differ as well. These are pre-existing discrepancies, not changes introduced by the prose edit. Reconcile the figure and text against the intended model outputs before circulating this revision as final. No analytical values were changed to make them agree.

The complementary pass traced the figure's lambda and uncertainty to `06_analysis/output/population_parameters.csv`, whereas `canonical_statistics.csv` retains the older manuscript values. Current bootstrap sensitivity outputs also report 132 imputed replicates rather than the manuscript's 43. Reconciliation must cover the model, uncertainty, sensitivity outputs, and downstream heatwave projections; simply replacing the displayed lambda would leave other inconsistent results.

## Resolution after author instruction to use the correct lambda

Reconstructed the full-data matrix from prepared cells and filtered growth records using the primary study-level REML estimator. Its eigenvalue matches the saved matrix to within 1e-10: lambda 0.959489041709. Saved bootstrap samples independently reproduce the 0.902–1.001 interval and 97.1% below replacement. Updated main text, ESM, README, canonical statistics, and figures accordingly. SC5 cell elasticity is 59.8%; aggregated SC5 survival elasticity is 61.2%. Four studies contribute survival and two contribute growth.

Repaired the manuscript-facing study-exclusion calculation to use the primary estimator, rather than the former individual-record weighted estimator. It now excludes all four contributing studies and removes fragmentation when Vardi is excluded. Lambda ranges from 0.889 (Vardi excluded) to 0.977 (Neely excluded); excluding NOAA gives 0.936. The former estimator is retained only as an exploratory diagnostic in script 16.

Reran the heatwave scenarios with the saved matrix and bootstrap samples. Baseline finite-horizon effective lambda is 0.935; 78.4% of simulations are below the 10% abundance threshold at year 50. Observed Florida endpoint effective lambdas are 0.355, 0.576, 0.768, and 0.849 for 5-, 10-, 20-, and 50-year recurrence. Corrected simulation descriptions to parameter uncertainty with fixed matrix structure, rather than environmental stochasticity or resampled full matrix structures. Added blocking reporting gates and independent reconstruction checks.

Verification used installed R 4.6.1 because the locked project library lacks required packages. The full 2,000-replicate bootstrap rerun was interrupted; the saved bootstrap distribution was checked, not regenerated. A clean-clone rerun under locked R 4.5.2 remains a release requirement. No user data or primary analysis assumptions were changed.

The complete `make verify R='Rscript --vanilla'` gate passed. Rebuilt both Word documents and inspected all 20 main-text and 10 supplement pages. Corrected the supplement's table-column grid and superscript units. Final PDFs were exported from the Word documents through the bundled LibreOffice renderer, not retained from the direct LaTeX build.

## Locked reproduction and robustness follow-up — 7 October 2026

The earlier release requirement is now satisfied for the primary matrix:
an isolated renv-restored rerun under locked R 4.5.2 regenerated prepared
data and all 2,000 bootstrap draws. The matrix and every lambda draw match
exactly. The 0.959 point estimate, 0.902–1.001 interval, and 97.1% fraction
below replacement are unchanged.

Added coordinated study-level resampling, missing-class distribution
imputation, separate Vardi survival/fragmentation exclusions, and 50-year
projections using all complete bootstrap matrices under four initial size
structures. Main Methods and Results report these checks; ESM Tables S3 and
S4 retain the details. Coordination is not described as an estimate of
temporal covariance, and conditional simulation fractions are not
population-viability probabilities. Primary 500-simulation results are
distinguished from the new 2,000-draw sensitivity.

The locked submission gate and all 20 new numerical reporting checks pass.
Rebuilt and visually inspected 21 main-text and 12 ESM pages; PDFs are Word
exports. Details and qualifications are recorded in
`07_reporting/internal/generated/matrix_robustness_validation_2026-10-07.md`.
This follow-up supersedes the unresolved-bootstrap status above, without
rewriting the historical audit.

## Discussion restructure — 7 October 2026

Reworked the Discussion with the discussion-writing and AI-writing QA skills.
The former short subsections were consolidated into three core sections, each
with multiple paragraphs: large-colony persistence, disturbance limits on
extrapolation, and restoration transitions. The revision names specific prior
studies in relation to the findings, distributes limitations next to their
consequences, removes figure callbacks, and closes by returning to the need to
restore colonies that become large and retain live tissue.

## Supplement restructure and AI-writing QA — 7 October 2026

Revised ESM_1 with the supplementary-material and AI-writing QA skills. The
ten sections now use finding-first headings that match the Contents, captions
state the estimand and relevant sample size before interpretation, and the
resampling and finite-horizon projection sections state their assumptions and
limits in the supplement itself. Removed workflow-like phrasing and rebuilt
the Word-derived PDF. The 12-page supplement was visually checked after export;
the repository vocabulary, robustness-reporting, display-item, and whitespace
checks all pass.

## Raine Detmer coauthor edits — 14 October 2026

Integrated the substantive comments in A. Raine Detmer's 13 October marked-up
Word draft. The abstract now distinguishes overall survival from movement
through size structure and states explicitly that the deterministic lambda is
below replacement. The Introduction clarifies that heatwave comparisons refer
to events of similar magnitude and replaces ambiguous material terminology with
colony source. Methods now define shrinkage (within-colony live-area loss) and
retrogression (crossing into a smaller size class) as distinct but related
estimands, including the possibility that a colony shrinks without crossing a
class boundary. Results report that the Florida Keys supplied 79% of
individual-level observations, and the acknowledgements no longer thank a
coauthor. Figure 2 uses one blue family for natural-colony survival and death
rugs; Figure 4 uses gray/green for lambda below/at-or-above replacement to
avoid conflating status colors with natural versus restoration records. The
author-contribution statement records Raine's figure production and manuscript
review. Main and supplementary headings and captions were synchronized to the
colony-source terminology.

## Follow-up consistency and render audit — 14 October 2026

Checked the geographic denominator directly against prepared_survival_data.rds:
6,222 Florida Keys records / 7,346 prepared survival records = 84.699%, reported
as 84.7%. The 79% figure above incorrectly divided a prepared numerator by the
raw-file denominator. Corrected Results and replaced the unsupported statement
that NOAA supplied 78% with the verified Florida Keys share in Discussion.
Clarified the abstract's heatwave result as a further reduction in effective
lambda to 0.849, since the unperturbed deterministic estimate was already below
replacement. Aligned restoration subtype names with the Methods. Corrected the
Figure 4 NOAA-exclusion color in its caption and described matrix entries rather
than transition probabilities because entries include fragment production.
Replaced HTML line breaks that disappeared in Word with Markdown hard breaks
for affiliations 7–9 and correspondence. Render warnings for low-text figure
pages and possible caption overflow were checked visually: the figures and their
labels are paired on the same pages.

## Introduction and Discussion voice revision — 14 October 2026

Applied the introduction, discussion, and Stier writing-voice skills, including
their 13 October corpus calibration. The Introduction now begins with the
conservation problem created by loss of large reef-building colonies, develops
the links among size, tissue loss, disturbance, and colony source, and ends with
the synthesis and its bounded objectives. The Discussion retains three core
subsections with multiple paragraphs. Each new topic establishes the ecological
question before interpreting the results and literature. Restoration paragraphs
specify the comparison or monitoring outcome needed to evaluate re-cementation,
adult protection, transfer size, and sexual recruitment. Preserved numerical
results, existing citations, and the limits of the recruitment-free model;
replaced the categorical demographic-bottleneck heading with a size-persistence
question that the elasticity and tissue-loss results support.

## Methods accounting and final presentation repairs — 14 October 2026

Defined RGR as annual areal change divided by initial area, with live-tissue
measurements preferred and total-colony measurements retained as fallbacks.
Reported survival filtering as 7,842 raw records minus 480 duplicates and 16
unusable records = 7,346 prepared records; growth filtering as 6,318 minus 423
duplicates = 5,895. Reconciled the meta-analysis denominator: 7,176 included
Tier 1 interval records plus 1,431 Tier 2 effect-level sample sizes = 8,607.
The 170 omitted prepared survival records comprise 52 Mendoza Quiroz records,
24 Neely records without usable interval duration, and 94 NOAA restoration
fragment records outside the natural-colony NOAA effects. Verified these
exclusions against the actual synthesis filters rather than assigning a reason
from the count difference.

Recounted the screening CSV: 104 rows, 19 included and 85 excluded. Consolidating
the duplicate Gladfelter row and all three Vardi parameter/publication entries
gives 101 sources, 18 included and 83 excluded. Replaced the active screening
summary and preserved the old narrative as an explicitly historical record.
Clarified that exact size-class boundaries enter the lower-numbered class and
that zero-area observations were removed. Reduced repeated restoration closing
language and added centered automatic PAGE fields to the main Word formatter.
