#!/usr/bin/env bash
set -euo pipefail
root="$(git rev-parse --show-toplevel)"
input="$root/paper/manuscript/combined_manuscript.md"
out="$root/paper/output/acropora_palmata_demography_manuscript"
word_input="$root/paper/manuscript/combined_manuscript_word.md"
csl="$root/paper/springer-basic-author-date.csl"

test -f "$input"
# Word does not reliably display embedded vector-PDF figures.  Build a
# Word-specific source that uses the matching high-resolution PNGs. The PDF is
# exported from this formatted Word file so the two deliverables agree.
sed 's|06_analysis/figures/manuscript/\([^)]*\)\.pdf|06_analysis/figures/manuscript/\1.png|g' \
  "$input" > "$word_input"
pandoc "$word_input" --citeproc --csl="$csl" --resource-path="$root:$root/07_reporting/manuscript:$root/paper" \
  --output="$out.docx"
"${DOCX_PYTHON:-python3}" "$root/paper/scripts/format_main_docx.py" "$out.docx"
"${DOCX_PYTHON:-python3}" "$root/paper/scripts/export_word_pdf.py" "$out.docx" "$out.pdf"
python3 "$root/paper/scripts/check_citations.py" "$input" \
  "$root/paper/manuscript/references.bib" \
  "$root/paper/manuscript/palmata_library.bib"
python3 "$root/tools/check_manuscript_pdf.py" "$out.pdf"
echo "[OK] rendered $out.{docx,pdf}"
