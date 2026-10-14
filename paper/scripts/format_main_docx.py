"""Keep headings black and figures with their captions after Pandoc export."""

import sys

from docx import Document
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.shared import RGBColor


def main(path):
    document = Document(path)
    for style in document.styles:
        if style.name in {"Title", "Subtitle"} or style.name.startswith("Heading"):
            style.font.color.rgb = RGBColor(0, 0, 0)
            color = style.element.find(".//" + qn("w:color"))
            if color is not None:
                for attr in ("themeColor", "themeTint", "themeShade"):
                    color.attrib.pop(qn("w:" + attr), None)
    for paragraph in document.paragraphs:
        if paragraph._p.findall(".//" + qn("w:drawing")):
            paragraph.paragraph_format.keep_with_next = True
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
