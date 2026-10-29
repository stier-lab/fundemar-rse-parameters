# Targeted prose pass: Discussion and restoration priorities table

Date: 2026-10-20

## Scope and changes

Applied the avoid-ai-writing skill to the revised Discussion and Table 1 only, with the Stier writing-voice scientific safeguards. Made 17 targeted replacements across 13 paragraph/table lines. Other manuscript sections, analysis, figures, and bibliography were not edited in this pass.

Removed repeated statements of model limitations, abstract evaluative framing, and unnecessary setup. Examples:

- “The synthesis adds evidence that remaining alive does not ensure remaining large” became “Survival did not ensure retention of colony size.”
- The cohort-monitoring paragraph now opens with the proposed observation: “We propose following every original outplant, pairing survival with repeat live-area measurements.”
- Shortened the Table 1 caption while retaining its explicit distinction between proposed research priorities and estimated intervention benefits.

Whitespace-delimited counts, including headings and citation markup: Discussion 1,944 → 1,787 words; Tables section 353 → 331 words. Total reduction: 179 words. Retained all three Discussion subsections and six table priorities.

## Evidence safeguards

Compared with `temp/anti_ai_restoration_2026-10-20/before_manuscript.md`: all citation occurrences retained in order; all numerical tokens retained with identical counts. Text before Discussion, acknowledgements/declarations, and figure legends onward is unchanged. Independent prose diagnostic passed without further necessary edits.

Retained noncausal source comparisons, shared-data qualifications, recruitment-free model scope, uncertainty, and the distinction between elasticity and achievable treatment benefit. Preserved the separate meanings of living area, genetic retention, reproduction, recruitment, and habitat recovery. Pattern checks were used as editing prompts, not as evidence about authorship.

## Build and verification

Rebuilt the canonical DOCX through `make -C paper render`; regenerated its PDF from the formatted Word file. Rendered the DOCX again to `temp/anti_ai_restoration_2026-10-20/render` and visually inspected all 27 pages. No new clipping, overlaps, detached figure labels, or split table rows observed. Table 1 fits on page 16; figures and their numbered labels remain together on pages 19–22. Intentional whitespace around the separately grouped figure legends remains unchanged in design.

Passed citation resolution (58 keys), qualitative claims (5), vocabulary, display-item coherence (41), matrix reporting (12), sensitivity reporting (20), and canonical-statistics checks (12 values). Current figure-embed checks passed for main text (4 images) and unchanged supplement (6 images). Main PDF has 27 nonblank pages; unchanged supplement has 12. Focused Word compatibility preflight passed; native Microsoft Word was not tested. The reviewed render and canonical PDF have identical extracted text.

No model refitting, supplement prose edits, email, commit, or push performed.
