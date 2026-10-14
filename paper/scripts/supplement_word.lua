-- Use high-resolution images and explicit page breaks in the Word supplement.
function Image(image)
  image.src = image.src:gsub('%.pdf$', '.png')
  return image
end
function RawBlock(block)
  if block.format == 'tex' and block.text:match('\\clearpage') then
    return pandoc.RawBlock('openxml', '<w:p><w:r><w:br w:type="page"/></w:r></w:p>')
  end
end
