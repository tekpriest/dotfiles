local M = {}

--@type Base64HLGroupsList
M.override = {
  Comment = { italic = true },
  LspReferenceWrite = { bg = 'none', fg = 'none' },
  LspReferenceRead = { bg = 'none', fg = 'none' },
  LspReferenceText = { bg = 'none', fg = 'none' },
}

--@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = 'green', bold = true },
}

return M
