#!/usr/bin/env python3
"""Check final Word embeds and Word-derived PDF integrity after a live-area rebuild."""
import csv
from hashlib import sha256
from pathlib import Path
import re
import subprocess
from xml.etree import ElementTree as ET
from zipfile import ZipFile

ROOT = Path(__file__).resolve().parents[1]
PACKAGES = [
    ("paper/output/acropora_palmata_demography_manuscript", [
        "manuscript/Fig1_study_landscape", "manuscript/Fig2_demographic_rates",
        "manuscript/Fig3_caribbean_synthesis", "manuscript/Fig4_population_model"]),
    ("paper/submission/supplement/ESM_1", [
        "supplementary/FigS1_growth_diagnostics", "supplementary/FigS8_natural_vs_restoration",
        "supplementary/FigS16_shrinkage_retrogression_summary",
        "supplementary/FigS17_disturbance_size_interaction",
        "supplementary/FigS19_restoration_subtype_sensitivity",
        "supplementary/FigS22_heatwave_scenarios"]),
]
W = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"
with (ROOT / "06_analysis/output/population_parameters.csv").open() as f:
    params = {r["parameter"]: float(r["value"]) for r in csv.DictReader(f)}
for base, figures in PACKAGES:
    with ZipFile(ROOT / f"{base}.docx") as archive:
        media = [archive.read(name) for name in archive.namelist()
                 if name.startswith("word/media/")]
        hashes = {sha256(content).hexdigest() for content in media}
        assert len(media) == len(figures), (base, "unexpected image count")
        for figure in figures:
            path = ROOT / "06_analysis/figures" / f"{figure}.png"
            assert sha256(path.read_bytes()).hexdigest() in hashes, (base, "stale image", figure)
        document = ET.fromstring(archive.read("word/document.xml"))
        text = " ".join(node.text or "" for node in document.iter(W + "t"))
        # Join within paragraphs before normalizing: formatting/citation runs
        # can split a title without introducing a visible space in Word.
        paragraphs = ["".join(t.text or "" for t in p.iter(W + "t"))
                      for p in document.iter(W + "p")]
        readable = re.sub(r"\s+", " ", " ".join(paragraphs))
        tables = list(document.iter(W + "tbl"))
        if base.endswith("ESM_1"):
            assert len(tables) == 5, (base, "missing supplementary table")
            with (ROOT / "05_data/standardized/apal_disturbance_stressor_timeline.csv").open() as f:
                n_events = len(list(csv.DictReader(f)))
            assert len(tables[1].findall(W + "tr")) == n_events + 1, (base, "incomplete event catalogue")
            assert "60% decline in coral cover on reefs in the US Virgin Islands" in readable, (base, "truncated reference title")
        else:
            assert len(tables) == 1 and "five supporting tables" in readable, (base, "stale resource description")
        for key in ("lambda", "lambda_ci_lower", "lambda_ci_upper"):
            assert f'{params[key]:.3f}' in text, (base, "stale model result", key)
        assert "81.2% to 60.0%" not in text, (base, "invalid subtype comparison")
        assert "@manzello2025" not in text, (base, "unrendered citation")
    extracted = subprocess.check_output(["pdftotext", str(ROOT / f"{base}.pdf"), "-"], text=True)
    pages = extracted.split("\f")
    if not pages[-1].strip():
        pages.pop()
    # A full-page raster figure may have only its running header/footer in
    # extracted text. Require text OR an embedded image, not arbitrary text
    # volume that mistakes a complete figure page for an empty page.
    listed = subprocess.check_output(["pdfimages", "-list", str(ROOT / f"{base}.pdf")], text=True)
    image_pages = {int(line.split()[0]) for line in listed.splitlines()
                   if line.split() and line.split()[0].isdigit()}
    assert all(len(page.strip()) > 50 or i in image_pages
               for i, page in enumerate(pages, 1)), (base, "blank PDF page")
    print(f"PASS - {base}: {len(figures)} current figure embeds; {len(pages)} nonblank Word-derived PDF pages.")
