# Study-Window Disturbance Coverage Audit

This audit rebuilds the curated disturbance overlay on prepared survival intervals and summarizes overlap by study window.

## Overall

- Intervals audited: 1,003
- Studies represented: 7
- Zero-overlap intervals: 35
- One-event intervals: 64
- Multi-event intervals: 904
- Baseline-exclusion intervals: 289

## By Study

| study | n_intervals | n_zero_overlap | n_one_overlap | n_multi_overlap | n_local_metadata_only | n_timeline_overlay | n_both_sources | n_baseline_exclusion | pct_with_any_overlap |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| NOAA_survey | 776 | 35 | 49 | 692 | 9 | 669 | 72 | 220 | 95.5 |
| neely_et_al_2022 | 95 | 0 | 0 | 95 | 0 | 57 | 38 | 10 | 100.0 |
| pausch_et_al_2018 | 70 | 0 | 0 | 70 | 0 | 70 | 0 | 46 | 100.0 |
| USGS_USVI_exp | 27 | 0 | 15 | 12 | 0 | 27 | 0 | 12 | 100.0 |
| kuffner_et_al_2020 | 27 | 0 | 0 | 27 | 0 | 27 | 0 | 0 | 100.0 |
| mendoza_quiroz_et_al_2023 | 7 | 0 | 0 | 7 | 0 | 7 | 0 | 0 | 100.0 |
| fundemar_fragments | 1 | 0 | 0 | 1 | 0 | 1 | 0 | 1 | 100.0 |

## Rebuild Check

- Exact field mismatches found: 0
