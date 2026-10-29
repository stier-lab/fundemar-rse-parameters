# Independent figure QA: corrected live-area rebuild

Date: 2026-10-19. Reviewer delegated under `pub-figure-pipeline`; read that skill, its Information-is-Beautiful reference and eight-dimension rubric, and the `coral-reefs` skill. Coral Reefs overrides generic editorial titles: letter-only lowercase panel tags, no in-figure titles, sans-serif text, 84/174-mm width and maximum 234-mm height. This is a figure audit, not a new analysis. No figure or source code was edited by this reviewer.

## Inspection scope and methods

Reviewed fresh October 19 PNGs for Fig. 4 and supporting Figs. S12, S14, S16, S22, S28, S29. S29 was not reviewed until its 13:02:45 regeneration. Inspected exported vector PDFs independently after rasterization for Fig. 4, S16, S22, and S29; remaining PDF rechecks follow the required fixes below. Checked PDF physical dimensions and font embedding with `pdfinfo` and `pdffonts`. At review, all listed PDF fonts were embedded. Files are small (approximately 43–88 KB each), not oversized raster submissions. Review PNGs are proxies; vector PDFs are the journal figure masters, so the stricter journal line-art raster resolution is not satisfied merely by a 300-dpi review PNG.

Figures 4, S16, S22 are approximately 174 × 180, 174 × 170, 174 × 180 mm; S12 is 174 × 160; S14 is 174 × 110; S28 is 174 × 210. S29 was 170 × 230 mm and should be reset to 174-mm journal width. Lowercase a–d tags are present except S29 uses a–d embedded in forbidden panel titles.

Generated deuteranopia, protanopia, and desaturated QA copies with `colorspace` from the exported PNG pixels; these are inspection-only artifacts, not replacement scientific figures. Color/monochrome inspection and post-fix PDF checks are recorded below as they complete.

## Blocking fixes identified in first pass

1. **S12 suppresses the SC1 confidence interval.** In script 28, panel b has a y lower limit of 0.4, while `bootstrap_confidence_intervals.csv` gives the SC1 lower bound as 0.379860697. The displayed upper cap and point are present, but the full errorbar layer is dropped for that class. Set an inclusive probability scale (e.g., 0–1.05), not a scale that removes valid uncertainty. This is a scientific display failure, not just clipping polish.
2. **S28 omits the most severe observed-endpoint result and labels the others NA.** `observed_2023_florida` has DHW NA by design; the plot builds labels/colors/sorting directly from DHW, producing “NA DHW” and an NA legend key. Its 5-year effective lambda is below the hardcoded 0.4 y lower bound, so that point disappears altogether. Explicitly label the observed Florida endpoint as an empirical mortality scenario, use a separate scenario category, and include zero on the y scale. Verify all 17 scenario rows are represented after the fix.
3. **S29 loses S9 identity.** Factor levels S0–S8 convert S9 to NA. The tornado omits its row, while other panels show NA instead of S9. Include all maintained levels or explicitly subset the whole display and caption; do not show an unlabeled NA scenario.
4. **S29 trajectory legend clips at the right edge.** Panel c's five long labels are forced into one row; the S8 label is visibly cut off in both PNG and PDF. Shorten labels and wrap the bottom legend into two/three rows, e.g. `guide_legend(nrow = 2, byrow = TRUE)`.
5. **S29 panel-d near-zero labels overlap.** S7/S8 20-/50-year numbers collide at the baseline. Use the same dodge positions as the bars and separate or suppress redundant zero labels with a documented rule; confirm values remain legible.
6. **S29 violates letter-only panel labeling.** Remove panel titles such as “a. Scenario sensitivity”; use patchwork lowercase tags and place descriptions in the external caption. Set the journal width to 174 mm and keep height ≤234 mm with room for external legend/caption handling.

These failures were sent directly to the main agent for correction. S12, S28 and S29 cannot pass until corrected exports are independently reinspected.

## Structured layout descriptions

### Fig. 4: population model

- Four panels in a balanced 2 × 2 grid: matrix heatmap upper left, elasticity upper right, bootstrap histogram lower left, study-exclusion dots lower right. Equal intended column widths; matrix cells remain square.
- Outer margins contain all tick labels and annotations. The lower-left heatmap color key and categorical legends occupy a common bottom band; no clipping observed in PNG/PDF.
- Lowercase tags a–d are separate from content. Axes align within each row; different variables appropriately retain different scales.
- Text hierarchy is clear: axis labels and tags are strongest, cell values and bootstrap annotations readable, source-leverage note uses orange emphasis. No missing lambda/arrow glyphs or cramped PDF tracking observed.
- New annotations agree with output-backed values: lambda 0.941, interval 0.892–0.982, 99.8% below replacement, n = 2,000, SC5 cell elasticity 54.1%; exclusions range 0.877–0.956 with NOAA 0.936.
- Minor recommendation: orange fragmentation dots in panel b are defined in the canonical manuscript caption, but adding a compact point legend/direct label would make the image independently interpretable. This is not a missing scientific definition when paired with its caption.

### Fig. S16: tissue loss and retrogression (ESM Fig. S3)

- Four equal-width panels in 2 × 2 layout: tissue-loss frequency, magnitude conditional on loss, transition composition, and source-specific frequency with size/color encodings.
- Clean margins; percentage labels and loss values remain above bars without clipping. Superscripts and annual units render correctly in PDF.
- Transition bars use three categories with a bottom legend; source names directly label the two source rows. Source-panel size and color keys sit outside the data region at the bottom.
- New tissue-loss labels are 19.4%, 31.3%, 41.0%, 43.8%, 45.8% across SC1–SC5; conditional mean losses are 3, 23, 194, 827, 2,752 cm²/yr. Retrogression labels are 6.0%, 16.2%, 18.8%, 11.8% for SC2–SC5, matching the regenerated transition CSV. The primary subset summary is n = 4,301 and 41.7% overall tissue loss.
- White space is balanced. Small SC1/SC2 magnitude bars are honestly tiny on a shared absolute-area scale; their direct values prevent ambiguity. These descriptive bars do not show resampling intervals; the caption/table must not imply that bar differences are tested contrasts.

### Fig. S22: heatwave scenarios (ESM Fig. S6)

- Three panels: dose-response curve upper left, trajectories upper right, severity/return-interval comparison across full-width lower panel. The wider trajectory panel is an intentional small departure from equal widths, accommodating five lines/ribbons.
- Both legends sit below their data panels, not inside trajectories; four return intervals are consistently ordered and colored. No clipped axes; DHW degree symbols and lambda render in vector PDF.
- Blue dotted deterministic reference is 0.941, distinct from dashed replacement at 1.0. The primary projection baseline has effective lambda 0.920860 and 93.2% below the year-50 threshold according to the regenerated CSV; the reference line must not be relabeled as finite-horizon baseline effective lambda.
- Minor recommendation: move “Baseline lambda = 0.941” off the dashed replacement line; in the PDF its text is crossed by that line. All letters remain decipherable, but a lower safe offset or a white `geom_label()` background would improve it.
- No misleading cap/truncation of observed Florida bars; its four return intervals appear in the lower panel. Trajectories share the same percent-initial scale and show the year-50 horizon explicitly.

### Fig. S12: sensitivity

- Two full-width stacked panels: sensitivity dots and class-specific survival uncertainty. Long categorical labels fit because the upper panel uses horizontal dots; the categorical color legend sits between panels.
- Corrected baseline 0.941 is annotated and the matched study exclusions appear at the expected positions. Boundary/filter estimates are exploratory and need their caption's estimator distinction.
- Principal failure is not font size: the probability scale excludes a valid SC1 lower confidence bound, removing that interval. Once the scale is fixed, recheck the lowest cap and the sloped size-class labels.

### Fig. S14: population projections

- Two equal-width side-by-side panels: deterministic size-class area trajectory, then deterministic/uncertainty total abundance. Common year scale 0–20 and initial n = 210.
- Stacked-area class legend is below panel a; deterministic versus uncertainty legend is below panel b. Although two series normally favor direct labels, dashed versus solid encoding plus external legend is readable and unambiguous here.
- New lambda 0.941 is visible. The endpoint annotation is 22 colonies at year 20, and the threshold is 21 (10% of initial abundance). Interval ribbons are nested and remain within panel bounds.
- No content clipping observed. Final-stage counts are not presented as empirical observations; plot/caption must preserve their model-derived status.

### Fig. S28: temporal synthesis

- Three full-width panels stacked vertically: independent IPM trajectories, a compact annual regime strip with sample-size bubbles, then canonical-matrix heatwave sensitivities.
- Relative heights sensibly prioritize the trajectories and heatwave panel. Regime colors and observation-count key sit below the strip; axes and year labels do not overlap.
- Principal failures are data/label loss in panel c: omitted 5-year observed endpoint and NA DHW labels. The observed endpoint must not be assigned a fictitious DHW merely to fit this palette.
- Bright yellow DHW/regime marks have low white-background contrast; improve with a darker gold or redundant shape/outline, especially for print. Red and orange groups also need distinguishable identities without relying solely on hue.

### Fig. S29: biological scenarios

- Four full-width stacked panels: tornado sensitivity, reproductive inflow shares, selected trajectories, and year-20/50 quasi-extinction proportions.
- Existing 170 × 230-mm output has ample vertical inter-panel gaps but crowded content in the long trajectory legend and near-zero bar labels. Redistribute that whitespace into a wrapped legend rather than reducing the type further.
- S0, S1, S4, S7, S8 trajectories use a shared logarithmic abundance axis. New summary values trace to the scenario CSV: S0 0.9407; S4 delta −0.1195; S7 +0.0732; S8 +0.1013. S9 exists in the CSV and therefore must not become NA in plots.
- The four full panel-title phrases violate journal letter-only instructions. Source/scope descriptions belong in the external legend. Recheck corrected S9 row, trajectory legend, and all near-zero numbers in PNG and PDF before passing.

## Initial rubric scores (before required fixes)

Eight dimensions are panel proportions, margins/clipping, axis alignment, legend system, text readability, spacing, color accessibility, data-ink ratio. Passing requires ≥32/40, no dimension <3, and text ≥4. Scores are not a substitute for repairing known scientific omissions.

| Figure | Proportions | Margins | Axes | Legends | Text | Spacing | Color | Data-ink | Total | First-pass disposition |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---|
| Fig. 4 | 5 | 4 | 4 | 4 | 4 | 4 | 4 | 5 | 34 | Pass; compact fragmentation key recommended |
| S16 | 4 | 5 | 4 | 4 | 4 | 4 | 4 | 5 | 34 | Pass |
| S22 | 4 | 4 | 4 | 4 | 4 | 4 | 4 | 5 | 33 | Pass; baseline label position recommended |
| S12 | 4 | 2 | 4 | 4 | 4 | 4 | 4 | 4 | 30 | Fail: confidence interval removed |
| S14 | 4 | 5 | 4 | 4 | 4 | 4 | 4 | 5 | 34 | Pass |
| S28 | 4 | 2 | 4 | 2 | 2 | 4 | 3 | 4 | 25 | Fail: omitted scenario and NA labels |
| S29 | 4 | 2 | 4 | 2 | 2 | 3 | 4 | 4 | 25 | Fail: lost S9, clipped legend, overlapping text, panel titles |

## Corrective iteration and independent final inspection

The main agent repaired the reported source issues and regenerated figures. A second inspection caught two newly introduced layout problems: S29's letter-only tags overlapped its vertical y-axis titles, and the first white-backed S22 baseline label obscured part of the moderate-scenario bars. Both were reported and repaired before final approval.

Final inspected versions: Fig. 4 at 13:04:02; S12 at 13:03:17; S14 at 13:03:19; S16 at 13:01:12; S22 at 13:06:15; S28 at 13:03:19; S29 at 13:06:09 (all 2026-10-19 Pacific). Independently rasterized and inspected the current vector PDFs for all seven figures. The final S29 PDF is 493 × 637 points, approximately 174 × 225 mm, and all font subsets are embedded. Its file size is approximately 45 KB. No native Word or physical print test was performed; final document placement is a separate manuscript render check.

Verified fixes:

- S12 now uses a probability scale including zero; SC1's full 0.3799–0.6989 confidence interval is visible in PNG and PDF.
- S28 shows all 17 heatwave-summary rows, including observed Florida recurrence at 5 years (the formerly dropped point near 0.35). Its observed-endpoint labels and purple category are explicit; no NA DHW label or NA key remains. The 8-DHW points now use darker gold. Long x labels fit without collision.
- S29 has all ten scenarios S0–S9 in panels b/d, and all nine departures S1–S9 in panel a. PDF text extraction finds S9 and no NA scenario. Selected trajectories remain explicitly a subset. The two-row short legend fits completely. Near-zero bar labels were removed rather than mispositioned; the percent scale and bars remain honest and legible. Lowercase tags are anchored inside panel corners, clear of vertical axis titles. Panel titles are removed and descriptions remain in the external figure legend.
- Fig. 4 now directly identifies orange fragmentation points as non-additive. Its bars, matrix values, bootstrap interval, fraction below replacement, and exclusions are unchanged by the layout fix.
- S22's baseline box now occupies the data-free band above all bars, with no bar hidden. The dotted corrected matrix reference remains distinct from replacement at one.

Color inspection: generated and visually inspected deuteranopia, protanopia, and desaturated variants. Primary conclusions remain readable. The matrix heatmap also has printed cell values; histograms and exclusion rows retain explicit labels; transition bars retain fixed order and percentage labels; heatwave bars have a consistent ordered return-interval mapping; S28 categories retain explicit x labels; S29 scenarios have explicit axis names. Some hues converge in monochrome, especially closely related trajectory colors, but their ordered positions, explicit categories, and trajectory separation preserve the comparison. This is a simulation check, not a claim of universal accessibility testing with human readers.

The reviewer also updated `07_reporting/manuscript/figure_legends.txt` for all ten S0–S9 scenarios and clarified that panel b's denominator is reproductive SC1 inflow only, excluding surviving colonies remaining in or moving into SC1. Canonical main/ESM sources remain owned by the main agent.

### Final rubric

| Figure | Proportions | Margins | Axes | Legends | Text | Spacing | Color | Data-ink | Total | Disposition |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---|
| Fig. 4 | 5 | 4 | 4 | 5 | 4 | 4 | 4 | 5 | 35 | Pass |
| S16 | 4 | 5 | 4 | 4 | 4 | 4 | 4 | 5 | 34 | Pass |
| S22 | 4 | 5 | 4 | 4 | 4 | 4 | 4 | 5 | 34 | Pass |
| S12 | 4 | 5 | 4 | 4 | 4 | 4 | 4 | 5 | 34 | Pass |
| S14 | 4 | 5 | 4 | 4 | 4 | 4 | 4 | 5 | 34 | Pass |
| S28 | 4 | 4 | 4 | 4 | 4 | 4 | 4 | 5 | 33 | Pass |
| S29 | 4 | 4 | 4 | 4 | 4 | 4 | 4 | 5 | 33 | Pass |

## Final disposition

All seven corrected exports meet the delegated gate: ≥32/40, no dimension below 3, text readability ≥4. All blocking omissions, clipping, and label collisions identified in this audit were fixed and the resulting exports reinspected. Final Word-derived main/supplement PDF page layout still requires the main agent's separate render QA; this figure pass does not certify their embedding or page breaks.
