# Authorized live-area rebuild 2026-10-19

## Outcome

Adrian authorized a consistent live-area transition estimator and a complete rebuild of its downstream consumers. This resolves the model hold recorded during the Jameal editorial integration. Main text retains Jameal's revisions and Aldo's reproductive-size and habitat distinctions.

The corrected recruitment-free matrix has lambda **0.940702161376**, with a 95% percentile-bootstrap interval of **0.891561341033–0.982442236691**. Of 2,000 valid draws, 1,995 (99.75%; reported as 99.8%) are below one. This is a resampling fraction, not a real-world probability of decline. Largest-class stasis remains the most influential cell, with elasticity **54.1%** (95% interval 39.2–68.2%). Fragmentation-free lambda is 0.880925; matched study exclusions span 0.877032–0.955969.

## Input correction

- Initial size and annual growth both use live planar area. Missing live measurements cannot fall back to skeletal area in conditional transitions or field/nursery growth exports.
- Observed endpoints are reconstructed with the actual interval duration. Nonpositive endpoints are excluded from conditional growth, while deaths remain in survival estimation. Independent raw-data checks verified NOAA annualization and the 24 zero-live endpoints recorded as deaths.
- The primary natural-colony transition panel retains 4,301 records after positive-endpoint, valid-duration, impossible-growth, 0.5–1.5-year and metric-specific upper-1% absolute-growth filters. The q99 cutoff is 10,393.64 cm² yr−1; source-class denominators are 36, 582, 1,213, 1,152 and 1,318.
- One-year area is initial live area plus annual live-area change, floored at 0.1 cm². Thirty-one observed subannual survivors extrapolate below zero over a full year; this approximation is disclosed rather than recoding their observed survival as death.
- Tissue loss and annualized class transitions now use the same primary panel: 41.7% lost tissue; SC5 tissue loss is 45.8% and annualized SC5 retrogression is 11.8%.
- Field/nursery exports retain their distinct, wider interval/filter eligibility and existing public bundle schemas. Metadata specifies live-area units, eligibility and endpoint rules. They are not represented as identical to the primary matrix estimator.

## Propagation and scope

Rebuilt the primary matrix and all 2,000 bootstrap matrices, eigenvalues, elasticities, projections and sensitivity outputs; matched study exclusions; coordinated-resampling and imputation sensitivities; Vardi component exclusions; tissue-loss summaries; primary heatwaves and full-matrix heatwave comparisons; baseline-dependent biological layers and S0–S9 scenarios; field/nursery parameter exports; affected figures; canonical registries and freshness reports. Updated manuscript results, methods, interpretation, ESM tables/captions, claim anchors and maintained public/interface documentation.

Primary heatwave simulations without pulses now have effective lambda 0.920860 and 93.2% below 10% initial abundance at year 50. Observed-Florida effective rates at 5-, 10-, 20- and 50-year recurrence are 0.350766, 0.568906, 0.757300 and 0.836840. Full-matrix original-composition baseline effective lambda is 0.921102, with 92.3% below threshold, compared with 94.05% in the paired lambda-only comparison. All observed-Florida endpoint scenarios fall below threshold in all simulations and starting compositions.

The survival meta-analysis and descriptive GAMs do not consume this matrix and were not refit solely for this correction. Their separately documented growth-measure fallback convention is not the conditional-transition rule. Raw source data were not changed; sexual recruitment remains zero in the primary model. The neighboring RSE analysis/model/app was not rerun or edited. Local RSE-facing parameter exports were updated, but this does not establish downstream sibling-repository adoption. Historical dated diagnostics retain their original values, with explicit supersession notices where needed. Dark slide variants were outside the manuscript rebuild.

## Verification

- Independent source audit: `live_area_model_audit.md`; NOAA raw live-area calculations and annualization checked.
- Independent inference audit: `live_area_inference_audit.md`; all 2,000 matrix eigenvalues, 6,000 resampling draws and 136 projection summaries independently reconstructed. All match within numerical tolerance. Export draws are finite, nonnegative and normalized. S0 matrix and lambda equal the canonical baseline.
- Independent figure audit: `live_area_figure_qa.md`; seven affected figures pass at 33–35/40 with readability at least 4. Fixed dropped SC1 uncertainty, omitted/NA-labeled observed heatwaves, missing S9 identity, clipped scenario legends, overlapping panel tags and ambiguous fragmentation labeling. Vector-PDF dimensions and embedded fonts checked.
- Independent prose check: `live_area_prose_qa.md`; no remaining close-to-replacement or interval-includes-one claim in revised passages, and no unsupported intervention-effect claim introduced.
- `make submit-check` passes with R 4.5.2 and the synchronized renv lockfile: live-area contract, matrix concordance, canonical statistics, 12 matrix-reporting checks, 20 sensitivity-reporting checks, five claim predicates, vocabulary, model inventory and 40 display items.
- Main 52 and supplement 18 Pandoc citation keys resolve. Final Word compatibility preflight passes; native Microsoft Word behavior was not tested.
- Final DOCX/PDF embed check confirms all four main and six supplement images are byte-identical to current source PNGs. The PDFs were exported from the formatted Word files, not separately typeset. No blank PDF pages remain.
- Visually inspected all 24 main and 12 supplement pages, with enlarged checks of corrected methods, Fig. 4 and Tables S3/S4. Fixed an overflowing standalone page-break paragraph after Fig. S3; the supplement returned from 13 to 12 pages without dropping content.

## Reproduction and deliverables

Run `make rebuild-live-area R=/Library/Frameworks/R.framework/Versions/4.5-arm64/Resources/bin/Rscript`, then `make submit-check` with the same R. The durable runner lists the ordered analysis stages and stops on failure. The saved downstream-stage execution manifest is `06_analysis/output/live_area_rebuild_manifest.csv`; script 13 was completed separately before that manifest began. Subsequent figure-only repair reruns and the export-metadata rerun are documented above; their logs are under ignored `temp/`.

Rebuild Word through `make -C paper render` and `paper/scripts/render_supplement.sh`, using the bundled document runtime and `DOCX_RENDERER`. Run `tools/check_live_area_documents.py` after both renders to detect stale embedded images, retired numerical claims and blank PDF pages.

Final files are `paper/output/acropora_palmata_demography_manuscript.docx` and `.pdf`, and `paper/submission/supplement/ESM_1.docx` and `.pdf`. No push, email or external distribution was performed for this request.
