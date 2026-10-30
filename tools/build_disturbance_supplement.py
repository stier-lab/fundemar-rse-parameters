#!/usr/bin/env python3
"""Expose the exact 18 screening windows, with source-resolved citations.

This is a reporting transform. It does not change event windows, region
matching, exclusion flags, severity fields, prepared data or fitted models.
Source labels were checked against original papers/agency accounts in the
October 2026 coauthor revision. The input's unsupported intensity and impact
numbers are deliberately not promoted into the reader-facing chronology.
"""
import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
INPUT = ROOT / "05_data/standardized/apal_disturbance_stressor_timeline.csv"
OUTPUT = ROOT / "07_reporting/manuscript/tables/TableS2_screening_catalogue.md"
ESM = ROOT / "paper/submission/supplement/ESM_1.md"
START, END = "<!-- disturbance-catalogue:start -->", "<!-- disturbance-catalogue:end -->"

# Keys resolve the input's abbreviated source labels, including the incorrect
# journal for Victoria-Salazar and an unverified Goergen/Noemi attribution.
# Expected windows fail closed if a later analytical change needs a new audit.
SOURCES = {
    "White-Band Disease Epizootic": (1978, 1984, "gladfelter1982; @aronsonprecht2001"),
    "Hurricane Hattie": (1961, 1961, "stoddart1963"),
    "Diadema Mass Mortality": (1983, 1984, "lessios1984"),
    "Hurricane Andrew": (1992, 1992, "fonglirman1995; @lirman1997"),
    "Cuevones Grounding": (1997, 1997, "victoriasalazar2023"),
    "2005 Hurricane Season": (2005, 2005, "williamsmiller2012"),
    "2005 Thermal Anomaly": (2005, 2006, "eakin2010; @miller2009"),
    "Sargassum Brown Tides": (2011, 2025, "vantussenbroek2017; @antoniomartinez2020"),
    "2010 Cold-Water Event": (2010, 2010, "lirman2011; @colella2012"),
    "3rd Global Bleaching": (2014, 2017, "eakin2019"),
    "Hurricane Irma": (2017, 2017, "noaa2017irma; @noaa2018irmaassessment"),
    "M/V Noemi Grounding": (2017, 2017, "noaa2017noemi"),
    "Playa Baracoa Pollution": (2005, 2021, "ramos2024"),
    "SCTLD Outbreak (Framework)": (2018, 2025, "alvarezfilip2022"),
    "2023 Marine Heatwave": (2023, 2023, "birkart2025; @manzello2025"),
    "Coastal Eutrophication": (1999, 2019, "banister2024"),
    "Snail Predation Trap": (2005, 2010, "williamsmiller2012; @miller2001"),
    "Diadema 2nd Die-off": (2022, 2022, "levitan2023"),
}
ROLES = {"acute_event": "Acute-event screen", "chronic_regime": "Chronic regime",
         "chronic_pressure": "Chronic pressure", "indirect_framework": "Indirect framework",
         "biotic_pressure": "Biotic pressure"}
NAMES = {
    "White-Band Disease Epizootic": "Historical white-band disease (coral disease)",
    "Diadema Mass Mortality": "First *Diadema* die-off (indirect herbivory loss)",
    "Sargassum Brown Tides": "Recurring *Sargassum* pressure",
    "3rd Global Bleaching": "2014–2017 global bleaching period",
    "M/V Noemi Grounding": "Noemi del Mar grounding (physical damage)",
    "Playa Baracoa Pollution": "Playa Baracoa monitoring / water-quality context",
    "SCTLD Outbreak (Framework)": "SCTLD in other corals (indirect framework loss)",
    "Coastal Eutrophication": "Florida occupancy / water-quality context",
    "Snail Predation Trap": "Recurring corallivorous-snail pressure",
    "Diadema 2nd Die-off": "Second *Diadema* die-off (indirect herbivory loss)",
}

def build():
    with INPUT.open() as f:
        rows = list(csv.DictReader(f))
    assert len(rows) == len(SOURCES) == 18
    assert {r["Event_Name"] for r in rows} == set(SOURCES)
    lines = [
        "**Table S2. Eighteen author-assigned regional screening windows defined the disturbance comparison.** "
        "The table lists every entry used by the matching algorithm. Years are inclusive analysis windows, "
        "not necessarily independently observed onset and end dates. Duration, biological mechanism, and "
        "analytical role are separate: an extended event can be assigned to the acute-event sensitivity. "
        "SCTLD means stony coral tissue loss disease. No entry establishes exposure or cause of death in a matched colony.",
        "", "| Event or contextual pressure | Matching region | Years | Duration; analytical role | Omit^a^ | Supporting sources |",
        "|:--|:--|:--|:--|:--:|:--|",
    ]
    for row in sorted(rows, key=lambda r: (int(r["Start_Year"]), int(r["End_Year"]), r["Event_Name"])):
        name = row["Event_Name"]
        y0, y1, sources = SOURCES[name]
        assert (int(row["Start_Year"]), int(row["End_Year"])) == (y0, y1), name
        assert row["Exclude_From_Baseline"] in {"TRUE", "FALSE"}
        period = str(y0) if y0 == y1 else f"{y0}–{y1}"
        label = NAMES.get(name, name)
        role = ROLES[row["Analysis_Tier"]]
        omit = "Yes" if row["Exclude_From_Baseline"] == "TRUE" else "No"
        lines.append(f'| {label} | {row["Region"]} | {period} | {row["Duration"]}; {role} | {omit} | [@{sources}] |')
    lines += [
        "", "^a^ Omit means that a matched observation interval was excluded from the acute-event sensitivity only; all intervals remained in the primary analyses. An interval matching several entries was flagged if any had Yes. Otherwise a match meant context-only pressure, and no match meant no curated overlap.",
        "", "**How the windows were assigned.** These are screening conventions rather than a complete Caribbean disturbance history. The 1978–1984 white-band period combines historical accounts. The 2011–2025 *Sargassum* and 2018–2025 SCTLD screens extend reported pressures beyond the years directly observed in their cited studies. The 1999–2019 Florida water-quality window follows occupancy-record coverage, and the 2005–2021 Cuban window follows monitoring coverage; neither identifies uninterrupted pollution at every reef. Sources support the event or pressure, not every chosen boundary or exclusion decision. Unsupported quantitative intensity and impact claims in the original working catalogue are not used as evidence here.",
        "", "**Geographic interpretation.** The matcher combined Florida Keys, Dry Tortugas, and Middle Keys labels as Florida, and local Mexican entries as Mexican Caribbean. Thus the local Cuevones grounding and Middle Keys water-quality context can match observations elsewhere in their broad reporting regions. Caribbean-wide entries match every represented region. The 2023 references document named Florida and Puerto Morelos losses, not uniform mortality throughout the Caribbean. *Diadema* die-offs and SCTLD in other corals describe indirect community changes, not diagnosed disease in *A. palmata*. Table S3 reports overlap with these choices; the three states cannot identify a causal disturbance effect.",
    ]
    result = "\n".join(lines) + "\n"
    OUTPUT.write_text(result)
    source = ESM.read_text()
    assert source.count(START) == source.count(END) == 1
    before, tail = source.split(START)
    _, after = tail.split(END)
    ESM.write_text(before + START + "\n" + result + END + after)
    print("PASS - all 18 input windows reported with their exact dates, roles, flags and source-resolved citations.")

if __name__ == "__main__":
    build()
