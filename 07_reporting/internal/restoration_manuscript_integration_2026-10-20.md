# Restoration priorities integration 20 October 2026

## Scope

Integrated the balanced two-page restoration brief into the canonical manuscript Discussion and a new main-text Table 1. Preserved the three Discussion subsections, all reported analysis results, authorship/declarations, and the supplement. The prior main source, bibliography, Word document and Word-derived PDF were copied to ignored `temp/restoration_manuscript_integration_2026-10-20/` before editing. No analysis or raw data was changed.

## Argument changes

- Credit Lirman and Vardi for established fragmentation and large-colony findings; describe our contribution as quantified tissue loss and integrated survival/live-area transitions with uncertainty, not discovery of those processes.
- Contrast observational size-dependent outplant survival with Pausch's single-genotype size experiment. Do not infer an optimal size or a treatment effect from pooled curves.
- Integrate heat-response studies as motivation for follow-up through maturation, not proof of lifetime resilience or causal superiority of sexual origin.
- Separate genetic safeguarding by restoration infrastructure from reef persistence, sexual replacement and habitat recovery.
- Connect targeted colony care to diagnosed losses and cause-specific published experiments. Keep care-versus-planting as a proposed comparison, not an effectiveness ranking.
- Specify original-cohort denominators, production losses and costs. Distinguish spawning/fertility from sexual recruitment.
- Table 1 contains all six priorities, proposed comparisons/actions and the measurements needed to evaluate them. It is cited in the Discussion, editable in Word, and unranked.

## New citation grounding

| Key | Evidence reviewed | Permitted use and boundary |
|---|---|---|
| `williams2014snails` | Williams et al. 2014, PeerJ 2:e680, DOI 10.7717/peerj.680. Earlier full-source check in the brief grounding crosswalk; current primary metadata/abstract verified via PubMed and indexed official PeerJ PDF. Direct PeerJ fetch returned 403; PMC returned a browser challenge, which was not bypassed. | Field removal reduced snails and feeding-scar prevalence. Does not establish generalized maintenance benefit, increased long-term live area, heatwave protection or superiority to planting. |
| `baums2019` | Local library p004907, PDF pp. 1–2; full authors from `litdb bib`; Ecological Applications 29:e01978. | Published mixed-genotype and genetic-diversity guidance. Our matrix does not identify optimal spacing or mixture. |
| `miller2024` | Local library p005198, PDF pp. 1–2 and 5–7. | Multi-species observational juvenile bleaching comparison, with highly affected older reproductive A. palmata cohort. No isolated causal sexual-origin effect or proven lifetime tolerance. |
| `karp2025` | Project PDF `Karp_etal_2025_heat_tolerance_Apalmata.pdf`, p. 953; complete author list and DOI from primary PDF. | Acute thermal tolerance associated with symbiont type. Not a demonstrated long-term effect of symbiont manipulation. |
| `muller2026` | Project PDF pp. 1–3; local library p005210; issue metadata confirmed at PubMed PMID 41273189 (2026, volume 40, e70168; online 2025). | Published evidence/argument for rescue infrastructure and genotype safeguarding. Not a benefit estimated by the synthesis matrix. |
| `ramosromero2026` | Official Springer article DOI 10.1007/s00338-026-02957-1, abstract and experimental design; version of record 14 September 2026. Four full authors checked against article. | Neighbor and reef-crest differences in fragment fate and growth. Not a removal-treatment trial or evidence for blanket clearing. Distinct from the already cited 2025 PeerJ study. |

Existing sources for size, fragmentation, sexual propagation and restoration goals retain the earlier source/claim checks in `restoration_one_pager_published_library_grounding.md`. No source-library originals or Zotero records were altered.

## Build and checks

The display-item index was updated before adding Table 1, and its checker now validates main-table caption, source, Discussion callout and numbering. The existing Word formatter applies a compact three-column layout, header repetition and unsplit rows to this specific table. Coral Reefs table conventions take precedence over generic document defaults: caption above and no vertical rules. Figures and their embedded PNG sources are unchanged. The PDF must continue to be exported from the formatted Word document through the bundled document renderer.

An independent prose diagnostic required by the writing skill passed. Its five concrete recommendations were adopted: bound heatwave compensation to the fitted model, distinguish sexual recruitment from all replacement, specify the subtype-coded dataset, count dead outplants as zero in cohort live area, and remove the repeated prediction interval while separating the regional-scale inference.

## Final verification

- Rebuilt through `make -C paper render` using the bundled Python runtime and document renderer. The canonical PDF is exported from the formatted DOCX, not generated separately from LaTeX.
- Inspected all 28 page images of the final DOCX render. Table 1 occupies page 17, with six body rows and three columns, readable 10.5-pt text, caption above, and no vertical rules. Long figure legends are kept intact and the figure section begins separately; no scientific figure content was changed.
- All 58 citation keys resolve, including the six new references. The six full reference titles appear in the Word bibliography; no new raw citation keys remain in the document. The DOI-only 2026 Ramos Romero entry is distinct from its 2025 PeerJ predecessor.
- Canonical statistics, matrix reporting (12 checks), sensitivity reporting (20 checks), claim ledger (5 claims), vocabulary lint, model inventory and display-item checks pass. The display index contains 41 items after Table 1 was added.
- Focused Word compatibility preflight passes; native Microsoft Word was not used for this check. The figure-embed/Word-derived-PDF gate passes for both the rebuilt main text and unchanged supplement.
- Render lint reports no errors. Its two image-height cautions concern existing Fig. 2 and Fig. 3 sizes; both images and their short figure labels were visually confirmed on the same respective pages (21 and 22), so the predicted orphan captions did not occur.
- Results, Abstract, Introduction, Materials and methods, declarations and supplement source are unchanged from the pre-edit main-source backup. No statistical refit, email, Git commit or push was performed.
