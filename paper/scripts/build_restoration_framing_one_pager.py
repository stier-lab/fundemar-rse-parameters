#!/usr/bin/env python3
"""Build the standalone restoration-framing note from its Markdown source."""
from pathlib import Path
import argparse
import re

from docx import Document
from docx.oxml.ns import qn
from docx.shared import Inches, Pt, RGBColor

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / "07_reporting/manuscript/restoration_synthesis_framing_one_pager.md"
OUTPUT = ROOT / "paper/output/palmata_restoration_synthesis_one_pager.docx"


def inline(paragraph, text):
    """Render the limited bold/italic markup used by this memo."""
    for token in re.split(r"(\*\*[^*]+\*\*|\*[^*]+\*)", text):
        if token.startswith("**") and token.endswith("**"):
            paragraph.add_run(token[2:-2]).bold = True
        elif token.startswith("*") and token.endswith("*"):
            paragraph.add_run(token[1:-1]).italic = True
        else:
            paragraph.add_run(token)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=SOURCE)
    parser.add_argument("--output", type=Path, default=OUTPUT)
    args = parser.parse_args()
    source = args.source if args.source.is_absolute() else ROOT / args.source
    output = args.output if args.output.is_absolute() else ROOT / args.output
    doc = Document()
    section = doc.sections[0]
    section.page_width, section.page_height = Inches(8.5), Inches(11)
    section.top_margin = section.bottom_margin = Inches(0.65)
    section.left_margin = section.right_margin = Inches(0.7)
    for name in ("Normal", "Title", "Heading 1"):
        style = doc.styles[name]
        style.font.name = "Times New Roman"
        style.font.color.rgb = RGBColor(0, 0, 0)
        fonts = style.element.get_or_add_rPr().get_or_add_rFonts()
        for attr in ("asciiTheme", "hAnsiTheme", "eastAsiaTheme", "cstheme", "csTheme"):
            fonts.attrib.pop(qn(f"w:{attr}"), None)
        for attr in ("ascii", "hAnsi", "eastAsia", "cs"):
            fonts.set(qn(f"w:{attr}"), "Times New Roman")
    # The runtime's base template may carry decorative paragraph borders.
    for border in list(doc.styles.element.iter(qn("w:pBdr"))):
        border.getparent().remove(border)
    normal = doc.styles["Normal"]
    normal.font.size = Pt(11)
    normal.paragraph_format.line_spacing = 1.03
    normal.paragraph_format.space_after = Pt(5)
    normal.paragraph_format.widow_control = True
    title = doc.styles["Title"]
    title.font.size = Pt(16)
    title.font.bold = True
    title.paragraph_format.space_after = Pt(9)
    title.paragraph_format.keep_with_next = True
    heading = doc.styles["Heading 1"]
    heading.font.size = Pt(12)
    heading.font.bold = True
    heading.paragraph_format.space_before = Pt(7)
    heading.paragraph_format.space_after = Pt(4)
    heading.paragraph_format.keep_with_next = True

    in_references = False
    page_break_pending = False
    title_text = ""
    for block in source.read_text().strip().split("\n\n"):
        if block.strip() == "<!-- pagebreak -->":
            page_break_pending = True
            continue
        if block.startswith("# "):
            paragraph = doc.add_paragraph(style="Title")
            inline(paragraph, block[2:])
            title_text = block[2:].replace("*", "")
        elif block.startswith("## "):
            paragraph = doc.add_paragraph(style="Heading 1")
            inline(paragraph, block[3:])
            in_references = block == "## Selected published references"
        else:
            paragraph = doc.add_paragraph()
            inline(paragraph, block.replace("\n", " "))
            if in_references:
                for run in paragraph.runs:
                    run.font.size = Pt(9.5)
                paragraph.paragraph_format.space_before = Pt(3)
        if page_break_pending:
            paragraph.paragraph_format.page_break_before = True
            page_break_pending = False
    doc.core_properties.title = title_text
    doc.core_properties.author = "Adrian C. Stier"
    doc.core_properties.subject = "Standalone framing note for the Acropora palmata demographic synthesis"
    output.parent.mkdir(parents=True, exist_ok=True)
    doc.save(output)
    print(output)


if __name__ == "__main__":
    main()
