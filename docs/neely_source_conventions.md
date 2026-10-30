# Neely source conventions and October 2026 corrections

The original April 1, 2026 workbook is immutable. Its SHA256 matches the original
email attachment. It has Site, Coral #, seven date/LAI pairs, and a locations
sheet; it does not contain Colony Type. Corrections are applied by durable
colony ID, timepoint and original worksheet row from `05_data/corrections/`.

- LAI is `((L+W+H)/3)^2 × live fraction`, an index rather than measured planar
  tissue area. Literal `live` establishes a live colony with unknown LAI; zero
  records death. Missing LAI is not zero. Growth needs two measured positive
  endpoints and a positive verified duration.
- Unknown dates are not filled from neighboring colonies without source
  confirmation. Karen's October 30 correction confirms DT1-4 TP1 as February
  23, 2011. Her Sombrero entries say October 19, 2021 while her email says the
  same survey as SR1, whose original TP3 date is October 19, 2012. The 2021
  literal would reverse the subsequent 2013 interval; these entries await
  clarification and are not applied. The proposed date is never silently
  replaced with a plausible year.
- MR3-115 and MR3-116 were identified by the collector as ACER rather than APAL.
  All timepoints/intervals for these two colony IDs are excluded, not merely
  the two missing-date cells. The original rows remain untouched.
- `fragment` describes physical origin, not restoration: Y is a verified
  fragment, N a verified nonfragment, U an unreported type. Karen states that
  AF means a naturally attached fragment. The shared extract lacks the column,
  so Neely records remain U until an ID/timepoint-linked source is supplied.
  Site identity, small size and later recruitment do not identify a fragment.
- A verified type must apply at an interval's start to define a prospective
  fragment cohort. End-of-interval attachment alone cannot establish cohort
  survival. Colony IDs/timepoints are unique; metadata joins fail on duplicates,
  missing IDs, changed worksheet locators or unrecognized codes.
- NOAA AF/SF records and any verified Neely AF are natural-origin material,
  never restoration outplants. NOAA's current AF/SF designation is selected at
  a live interval endpoint, so those records cannot estimate fragment survival.
  Their measured survivor growth remains usable under the stated growth rules.
- `prepared_survival_inventory.rds` retains known fates and source sampling
  metadata. `prepared_survival_data.rds` and the individual-derived survival
  cells exclude endpoint-selected fragment records and unverified durations.
  Thus no downstream model can assign those records to restoration or silently
  give a missing duration the value one year. Inventory figures opt in to the
  full source record set; subtype figures must withhold non-estimable survival.

Raw correspondence and the returned unaltered CSV are held in the local private
review archive. The correction tables contain only the source-backed actions
needed to reproduce ingestion. Original study/plot/colony identifiers and both
2012 monitoring rounds are preserved. Biological conclusions are rebuilt from
the corrected objects rather than carried over from the preceding manuscript.
