# Neely source conventions and collector corrections

The original April 1, 2026 date/LAI workbook is immutable. Collector corrections
are maintained as overlays in `05_data/corrections/`, joined by durable colony ID
and original worksheet locator. The October 31 colony-type workbook is preserved
unchanged in the private review archive (SHA256
`33931c7d26753ac1d4dd9180c00923871cd63397656a92f190e0ecb2b0ae9cad`).

- LAI is `((L+W+H)/3)^2 × live fraction`, an index rather than measured planar
  tissue area. Literal `live` establishes survival with unmeasured LAI; zero
  records death. Missing LAI is not zero. Growth requires paired measurements
  and a positive, source-verified duration.
- Karen confirmed on October 31 that the Sombrero correction is October 19,
  **2012**, not 2021. The 11 affected date cells are now applied along with the
  previously confirmed DT1-4 date (February 23, 2011). The 21 Sombrero intervals
  no longer require duration withholding. Both distinct 2012 rounds remain.
- MR1-58, MR3-115 and MR3-116 are collector-identified ACER rather than APAL.
  Every observation/interval for all three is excluded. Original rows remain
  untouched; the species-exclusion audit preserves the exact locators.
- **Every colony in the Neely study is wild.** Natural fragmentation and
  restoration origin are separate attributes. No Neely record is a restoration
  outplant or receives a post-outplant age.
- The new metadata are explicitly **status at first sighting**, not morphology
  measured repeatedly. BR, EN and REMNANT can change through time and are not
  analyzed as stable morphotypes or evidence of nonfragment/sexual origin.
  Those records keep `fragment = U`. AF identifies a collector-verified newly
  attached natural-fragment cohort (`fragment = Y`) followed from first sighting;
  follow-up intervals remain in that origin cohort without claiming that their
  current morphology is still AF. No fragment status is inferred from a late
  first appearance, site identity, size, fate or suspected clonality.
- Metadata have 902 named IDs; only exact matches to the 878-ID demographic
  extract are used. Four extract IDs lack a match and retain unknown type:
  SK2-29e, LK3-3, SR2-7 and SR3-6. The 28 metadata-only IDs do not create new
  demographic observations. Two blank-ID metadata rows cannot be linked.
  `neely_colony_type_source_audit.csv` records matched, unmatched, metadata-only
  and excluded-species cases. Duplicate IDs or unrecognized codes stop ingestion.
- The two initially loose fragments (WS1-6, WS1-21) both died before the next
  survey. They remain in the raw and prepared inventories. Primary Neely
  survival is restricted to the consistently monitored attached-colony protocol:
  loose fragments were tagged only during the first round, whereas later
  fragments entered monitoring after attachment. These two records are withheld
  by protocol, not recoded as attached or silently deleted because they died.
  `neely_attachment_protocol_sensitivity.csv` shows their effect on the observed
  interval-survival proportion when included. They never enter the AF subgroup.
- NOAA AF/SF records are also natural, not outplants, but their designation is
  selected at a live interval endpoint. Their survival cannot estimate an
  at-risk fragment cohort. Measured survivor growth remains usable. This differs
  from the Neely first-sighting cohort; their survival summaries stay separate.
- `prepared_survival_inventory.rds` retains known fates and sampling metadata.
  Primary `prepared_survival_data.rds` and individual-derived survival cells
  exclude endpoint-selected NOAA fragments, the inconsistent loose-fragment
  protocol, and any unverified durations. Missing duration never becomes one year.
- Newly sighted AF records provide subsequent survival/growth information, not
  parent-specific fragment production. They do not provide the parentage,
  detection or at-risk parent denominator needed to estimate fecundity. Vardi
  remains the single fragmentation-production source; the collector's narrative
  site increase is not inserted as a quantitative production rate.

The 2014 source flags remain bleaching/site context, not diagnosed disease.
All biological outputs and manuscript values are rebuilt from these corrected
records; private correspondence is not part of the public analytical inputs.
