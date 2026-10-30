#!/usr/bin/env bash
set -euo pipefail

root="$(git rev-parse --show-toplevel)"
input="$root/paper/submission/supplement/ESM_1.md"
output="$root/paper/submission/supplement/ESM_1.pdf"
word_output="$root/paper/submission/supplement/ESM_1.docx"

"${DOCX_PYTHON:-python3}" "$root/tools/build_disturbance_supplement.py"
"${DOCX_PYTHON:-python3}" "$root/paper/scripts/check_citations.py" "$input" \
  "$root/paper/manuscript/references.bib" \
  "$root/paper/manuscript/palmata_library.bib" \
  "$root/paper/manuscript/disturbance_sources.bib"

pandoc "$input" --citeproc --csl="$root/paper/springer-basic-author-date.csl" --resource-path="$root" \
  --lua-filter="$root/paper/scripts/supplement_word.lua" --output="$word_output"
"${DOCX_PYTHON:-python3}" "$root/paper/scripts/format_supplement_docx.py" "$word_output" "$word_output"

"${DOCX_PYTHON:-python3}" "$root/paper/scripts/export_word_pdf.py" "$word_output" "$output"
python3 "$root/tools/check_manuscript_pdf.py" "$output"
echo "[OK] rendered $output"
