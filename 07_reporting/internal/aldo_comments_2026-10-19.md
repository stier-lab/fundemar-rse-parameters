# Aldo Croquer review response record

Review received 19 October 2026 in the thread “Acropora palmata synthesis draft for your feedback”. The attached Word document contained 21 comments and no tracked insertions or deletions. Aldo confirmed coauthorship in his email.

## Reply sent

Sent from astier@ucsb.edu to aldo.croquer@tnc.org in the existing thread. Gmail message `1a154f39eef8514b`, thread `1a14a50a739cb370`; SENT status and thread membership verified. The reply thanked him and asked:

1. Whether a minimum live-tissue size can establish reproductive maturity in A. palmata, or direct spawning evidence is needed.
2. Which A. palmata studies best link partial mortality to persistence of skeletal structure or changes in reproduction.

Neither answer is assumed in the revisions. No reproductive threshold or skeletal persistence time was introduced.

## Comment dispositions

| Comment IDs | Topic | Action |
|---|---|---|
| 1, 7, 16, 36 | Metapopulation dynamics and spatial context | Added the distinction between conditional colony transitions and connected populations. Named fecundity, fertilization, dispersal, settlement, and early survival as the missing processes. Kept a spatially explicit model as a follow-on rather than fitting unmeasured processes. |
| 2, 3, 5 | Survival/growth, reproductive contribution, and goal-specific monitoring | Revised abstract and Introduction to distinguish maintaining large living colonies from reproductive and ecosystem recovery. Monitoring recommendations now match these separate objectives. Did not imply that growth and survival together measure reproduction or ecosystem recovery. |
| 4 | Does retrogression cross minimum reproductive size? | Explained that size bins are not verified reproductive states. Asked Aldo about the evidence needed to define maturity; no new threshold assumed. |
| 8 | Demographic models for A. cervicornis | Added Mercado-Molina et al. (2015), after reading its demographic and outplant simulations. Explicitly identified it as a sister-species precedent, not A. palmata data. |
| 11 | PRISMA figure | Added a compact selection-count reconciliation on the supplement contents page and a main-text pointer. Did not manufacture an exact flow from approximate early search totals. Verified counts remain 101 assessed, 83 excluded, 18 included. |
| 13 | Size-class criteria | Replaced the vague rationale with the retained 100, 900, and 4,000 cm² boundaries from Vardi et al. (2012), their relation to branch development/reproductive potential, and the additional 10 cm² subdivision. Distinguished area classes from observed origin or maturity. |
| 24, 27 | Positive reactions to Results | No substantive edit required. |
| 25 | Small-fragment growth/survival trade-off | Existing Discussion already separates rapid proportional growth from survival and cautions against a planting threshold. Retained that distinction without generalizing microfragmentation experiments to the field synthesis (which excluded lab fragments below 1 cm²). |
| 30 | Citation for 2023 Florida mortality | Added Manzello et al. (2025) directly to the flagged Results sentence. |
| 32, 33, 34 | Population rehabilitation, reproduction, and standing skeleton | Reframed Discussion opening around populations. Separated measured live-area loss from unmeasured skeletal complexity and reproductive output. Standing skeleton may remain after tissue loss, but no persistence duration or quantitative habitat-loss relationship is asserted. Awaiting Aldo's preferred supporting studies. Existing Piñón-González and Banaszak (2018) evidence on partial mortality and eggs remains in the Introduction. |
| 39 | Schill et al. (2021) and Mercado-Molina | Added Schill's mapped site-selection example where site confounding is discussed. Preserved species and observational scope. Added Mercado-Molina in Introduction. |
| 40, 41 | Replacement versus effective return | Used “colony replacement” for the size-transition inference. Added Croquer et al. (2026), defining effective return as outplants becoming reproductive. Explicitly stated that this synthesis does not estimate that outcome. |

## Scope and verification

No data, model estimates, study inclusion decisions, numerical results, or figure panels were changed. The 2026 Croquer paper is contextual literature, not a nineteenth demographic study. Main manuscript and Online Resource 1 are rebuilt from their editable sources. The existing supplement formatter's blindly appended `keepNext` property was replaced by python-docx's schema-ordered property setter after compatibility preflight detected invalid paragraph-property order.

The independent prose check identified residual “adult class” language inconsistent with unverified maturity. Operational recommendations now refer to the largest size class and large-colony attainment. The abstract contains 190 whitespace-delimited words.

## Latest follow-up integrated

Aldo replied at 17:16:56 UTC (10:16:56 Pacific), message `1a1552ab628cda0a`, identifying a Soong/Lang reproductive-size study from memory. The intended source is Soong and Lang (1992), *Reproductive integration in reef corals*, not a 1990/1999 paper. Read the original Methods and Tables VI–VII. The smallest fertile A. palmata was 16 × 8 cm; the operational puberty-size estimate was 1,600 cm², defined from the smallest colony in the first consecutive size-ranked group of 20 with at least 90% fertile. These are different observations, not interchangeable maturity cutoffs. Source area sums living surface area of branches and the colony base, whereas the synthesis uses live planar area.

Added the source-grounded distinction to the Discussion and Online Resource 1, with a verified `soonglang1992` bibliography entry and an unchanged local copy of the already-held PDF. Independent prose/source QA confirmed that neither passage maps fertility onto the five classes or changes lambda. No fecundity parameter, sexual recruitment, study inclusion, or numerical estimate was changed. Aldo did not provide a skeletal-persistence reference in this reply, so no such evidence was inferred. This integration does not authorize or trigger another email to collaborators.

Verification completed with the pinned R 4.5.2 runtime: `make submit-check` passed all matrix concordance, source/reporting, model inventory, display, and renv checks. Deterministic lambda reconstructed as 0.959489041709. Default Homebrew R had first failed because it lacked dplyr; no packages were installed or lockfile changed. Rebuilt Word-derived PDFs contain 22 main-text pages and 12 supplement pages. Word compatibility preflight passes for both documents; new citations and their bibliography entries are present, with four main figures, six supplement figures, and four supplement tables. Render-check warnings about image-only figure pages were checked against page images: Figures 2 and 3 retain their captions on the same pages. The supplement uses 0.75-inch side margins, so 174-mm images fit its actual text block. Native Microsoft Word was not used for this QA.
