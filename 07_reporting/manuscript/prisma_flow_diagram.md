# Study selection and screening reconciliation

Updated 14 October 2026 from `03_screening/full_text_screening.csv`.

## Current counts

| Stage | Count | Basis |
|:--|--:|:--|
| Records identified across searches | Approximately 2,500 | Early search totals were not recorded uniformly; these are approximate identification counts, not unique screened sources. |
| Screening ledger rows | 104 | All data rows in the master screening CSV. |
| Included ledger rows | 19 | Rows marked INCLUDED. |
| Excluded ledger rows | 85 | Rows marked EXCLUDED. |
| Duplicate or additional within-study rows consolidated | 3 | One repeated Gladfelter et al. 1978 row; two additional Vardi rows. |
| Distinct study/data sources assessed | 101 | 104 minus 3 consolidated rows. |
| Distinct sources included | 18 | 19 included rows minus one additional included Vardi row. |
| Distinct sources excluded | 83 | 85 excluded rows minus the Gladfelter duplicate and the Vardi parameter-specific exclusion belonging to an included study. |
| Individual-record studies (Tier 1) | 7 | Includes Mendoza Quiroz and the April 2026 Neely data sharing. |
| Summary-record studies (Tier 2) | 11 | Includes the consolidated Vardi study. |
| Studies contributing survival-synthesis effects | 17 | Mendoza Quiroz supplied size-dependent vital-rate observations but no survival-synthesis effect. |
| Survival-synthesis effects | 22 | NOAA and Vardi each supply three effects; Garrison and Ward supplies two; the remaining fourteen studies supply one each. |

The reconciliation is **101 assessed = 18 included + 83 excluded**.

## Consolidation rule

Gladfelter et al. 1978 appears in both the original and expanded search phases;
both rows are excluded and represent one source. Vardi 2011, Vardi et al. 2011,
and Vardi et al. 2012 represent the same underlying demographic study. Two rows
are included for eligible survival/fragmentation data; one is excluded for
model-derived growth transitions. At the study level, this is one included
source with a parameter-specific exclusion, rather than an additional excluded
study. All other source identifiers are counted once as recorded in the ledger.

The original row-level decisions remain unchanged. Publication variants and
parameter-specific decisions can be inspected in the screening CSV; the
study-level count does not erase their provenance.

## Interpretation of search totals

Original searches ran from June through December 2025, expanded searches in
March 2026, and additional data sharing in April 2026. Identification and
title/abstract totals were not recorded consistently during the original search,
so they should not be presented as an exact, fully balanced PRISMA flow.
The full-text/repository assessment counts above are directly reproducible from
the current screening ledger. The previous March narrative and its older
82-exclusion summary are preserved in
`07_reporting/internal/prisma_flow_diagram_historical_2026-03.md`.
