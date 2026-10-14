#!/usr/bin/env python3
"""Export the formatted Word artifact; never generate a different PDF layout."""
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

source, target = map(lambda p: Path(p).resolve(), sys.argv[1:3])
renderer = os.environ.get("DOCX_RENDERER")
with tempfile.TemporaryDirectory(prefix="palmata-word-export-") as tmp:
    if renderer:
        if not Path(renderer).is_file():
            raise SystemExit("DOCX_RENDERER must point to the document renderer script")
        subprocess.run([sys.executable, renderer, str(source), "--output_dir", tmp, "--emit_pdf"], check=True)
    else:
        office = shutil.which("soffice") or shutil.which("libreoffice")
        if not office:
            raise SystemExit("Word-to-PDF export requires DOCX_RENDERER or LibreOffice on PATH; no separate LaTeX PDF was substituted.")
        profile = Path(tmp) / "office-profile"
        subprocess.run([office, f"-env:UserInstallation={profile.as_uri()}", "--headless",
                        "--convert-to", "pdf", "--outdir", tmp, str(source)], check=True)
    pdf = Path(tmp) / f"{source.stem}.pdf"
    if not pdf.is_file() or pdf.stat().st_size == 0:
        raise SystemExit("Word-to-PDF export did not produce a nonempty PDF")
    shutil.copy2(pdf, target)
print(f"[OK] PDF exported from {source.name}")
