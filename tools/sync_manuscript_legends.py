#!/usr/bin/env python3
"""Refresh maintained caption blocks without recycling historical result prose."""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
main = (ROOT / "07_reporting/manuscript/acropora_palmata_demography_manuscript_draft.md").read_text()
esm = (ROOT / "paper/submission/supplement/ESM_1.md").read_text()
path = ROOT / "07_reporting/manuscript/figure_legends.txt"
text = path.read_text()
captions = {}
for number in range(1, 5):
    captions[f"FIGURE {number}"] = next(line for line in main.splitlines()
                                         if line.startswith(f"**Fig. {number}** ")).replace("**", "")
for uploaded, repository in {1: 1, 2: 8, 3: 16, 4: 17, 5: 19, 6: 22}.items():
    caption = next(line for line in esm.splitlines() if line.startswith(f"**Fig. S{uploaded}."))
    captions[f"SUPPLEMENTARY FIGURE S{repository}"] = (
        caption.replace(f"**Fig. S{uploaded}.", f"**Fig. S{repository}.", 1).replace("**", "")
        + f" [Uploaded as Online Resource 1, Fig. S{uploaded}.]"
    )
separator = "=" * 80
pattern = re.compile(rf"{separator}\n((?:SUPPLEMENTARY )?FIGURE S?\d+)\n{separator}\n.*?(?=\n{separator}\n|\Z)", re.S)
seen = set()
def replace(match):
    name = match[1]
    if name not in captions:
        return match[0]
    seen.add(name)
    return (f"{separator}\n{name}\n{separator}\n\nLEGEND:\n{captions[name]}\n\n"
            "METHODS AND RESULTS:\nUse the current canonical main manuscript and Online Resource 1.\n"
            "This caption index does not duplicate their numerical results.\n\n")
updated = pattern.sub(replace, text)
assert seen == set(captions), (set(captions) - seen)
path.write_text(updated)
print(f"PASS - {len(seen)} maintained caption blocks synchronized to current manuscript sources.")
