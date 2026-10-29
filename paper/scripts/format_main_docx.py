"""Keep headings black and figures with their captions after Pandoc export."""

import sys

from docx import Document
from docx.enum.table import WD_CELL_VERTICAL_ALIGNMENT
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.shared import Inches, Pt, RGBColor


def format_priority_table(document):
    """Keep the six proposed priorities editable and on a separate review page."""
    for paragraph in document.paragraphs:
        if document.tables and paragraph.text in {"Tables", "Figure legends", "Figures"}:
            paragraph.paragraph_format.page_break_before = True
        if paragraph.text.startswith("Table 1. "):
            paragraph.paragraph_format.keep_with_next = True
            paragraph.paragraph_format.space_after = Pt(7)
    for table in document.tables:
        if [cell.text for cell in table.rows[0].cells] != [
            "Priority", "Proposed comparison or action", "Measurements needed"
        ]:
            continue
        table.autofit = False
        widths = [Inches(1.25), Inches(2.95), Inches(2.3)]
        for column, width in zip(table.columns, widths):
            column.width = width
        properties = table._tbl.tblPr
        borders = properties.find(qn("w:tblBorders"))
        if borders is None:
            borders = OxmlElement("w:tblBorders")
            # tblBorders follows cell spacing/indent and precedes shading/layout.
            properties.insert_element_before(
                borders, "w:shd", "w:tblLayout", "w:tblCellMar", "w:tblLook",
                "w:tblCaption", "w:tblDescription", "w:tblPrChange"
            )
        for name in ("top", "left", "bottom", "right", "insideH", "insideV"):
            border = borders.find(qn(f"w:{name}"))
            if border is None:
                border = OxmlElement(f"w:{name}")
                borders.append(border)
            border.set(qn("w:val"), "single" if name in {"top", "bottom", "insideH"} else "nil")
            border.set(qn("w:sz"), "4")
            border.set(qn("w:color"), "B0B0B0")
        margins = properties.find(qn("w:tblCellMar"))
        if margins is None:
            margins = OxmlElement("w:tblCellMar")
            properties.insert_element_before(
                margins, "w:tblLook", "w:tblCaption", "w:tblDescription", "w:tblPrChange"
            )
        for name, value in (("top", 90), ("left", 85), ("bottom", 90), ("right", 85)):
            margin = margins.find(qn(f"w:{name}"))
            if margin is None:
                margin = OxmlElement(f"w:{name}")
                margins.append(margin)
            margin.set(qn("w:w"), str(value))
            margin.set(qn("w:type"), "dxa")
        for index, row in enumerate(table.rows):
            row_properties = row._tr.get_or_add_trPr()
            if row_properties.find(qn("w:cantSplit")) is None:
                row_properties.append(OxmlElement("w:cantSplit"))
            if index == 0 and row_properties.find(qn("w:tblHeader")) is None:
                row_properties.append(OxmlElement("w:tblHeader"))
            for cell, width in zip(row.cells, widths):
                cell.width = width
                cell.vertical_alignment = WD_CELL_VERTICAL_ALIGNMENT.TOP
                for paragraph in cell.paragraphs:
                    paragraph.paragraph_format.space_before = Pt(0)
                    paragraph.paragraph_format.space_after = Pt(0)
                    paragraph.paragraph_format.line_spacing = 1.05
                    # Keep the whole compact table together, including its last row.
                    paragraph.paragraph_format.keep_with_next = index < len(table.rows) - 1
                    for run in paragraph.runs:
                        run.font.name = "Times New Roman"
                        run.font.size = Pt(10.5)


def main(path):
    document = Document(path)
    format_priority_table(document)
    for style in document.styles:
        if style.name in {"Title", "Subtitle"} or style.name.startswith("Heading"):
            style.font.color.rgb = RGBColor(0, 0, 0)
            color = style.element.find(".//" + qn("w:color"))
            if color is not None:
                for attr in ("themeColor", "themeTint", "themeShade"):
                    color.attrib.pop(qn("w:" + attr), None)
    for paragraph in document.paragraphs:
        if paragraph.style.name == "Bibliography":
            paragraph.paragraph_format.line_spacing = 1.0
            paragraph.paragraph_format.space_before = Pt(0)
            paragraph.paragraph_format.space_after = Pt(5)
        if paragraph.text.strip() == "References":
            paragraph.paragraph_format.page_break_before = True
        if paragraph._p.findall(".//" + qn("w:drawing")):
            paragraph.paragraph_format.keep_with_next = True
        if paragraph.text.startswith(("Fig. 1 ", "Fig. 2 ", "Fig. 3 ", "Fig. 4 ")):
            paragraph.paragraph_format.keep_together = True
            paragraph.paragraph_format.line_spacing = 1.0
            paragraph.paragraph_format.space_after = Pt(6)
    for section in document.sections:
        section.different_first_page_header_footer = False
        footer = section.footer
        if footer._element.findall(".//" + qn("w:fldSimple")):
            continue
        paragraph = footer.paragraphs[0]
        paragraph.alignment = WD_ALIGN_PARAGRAPH.CENTER
        field = OxmlElement("w:fldSimple")
        field.set(qn("w:instr"), "PAGE")
        run = OxmlElement("w:r")
        properties = OxmlElement("w:rPr")
        size = OxmlElement("w:sz")
        size.set(qn("w:val"), "20")
        properties.append(size)
        run.append(properties)
        text = OxmlElement("w:t")
        text.text = "1"
        run.append(text)
        field.append(run)
        paragraph._p.append(field)
    document.save(path)


if __name__ == "__main__":
    main(sys.argv[1])
