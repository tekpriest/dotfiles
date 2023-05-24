local M = {}

--@type Base64HLGroupsList
M.override = {
  Comment = { italic = true },
  LspReferenceWrite = { bg = 'none', fg = 'none', bold = true },
  LspReferenceRead = { bg = 'none', fg = 'none', bold = true },
  LspReferenceText = { bg = 'none', fg = 'none', bold = true },
  Keyword = { italic = true },
  Identifier = { italic = true },
  StorageClass = { italic = true },
  jsLineComment = { italic = true },
  xmlAttrib = { italic = true },
  htmlArg = { italic = true },
  pythonSelf = { italic = true },
}

--@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = 'green', bold = true },
}

return M
