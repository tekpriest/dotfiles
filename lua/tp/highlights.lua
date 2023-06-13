local hl = vim.api.nvim_set_hl

hl(0, 'Normal', { bg = 'none' })
hl(0, 'StatusLine', { bg = 'none' })
hl(0, 'StatusLineNC', { bg = 'none' })
hl(0, 'NormalNC', { bg = 'none', fg = 'none' })
hl(0, 'NonText', { bg = 'none' })
hl(0, 'SignColumn', { bg = 'none' })
hl(0, 'Structure', { bg = 'none' })
hl(0, 'LineNr', { bg = 'none', italic = true, fg = '#777777' })
hl(0, 'NormalFloat', { bg = 'none' })
hl(0, 'LspReferenceRead', { bg = 'none', bold = true })
hl(0, 'LspReferenceWrite', { bg = 'none', bold = true })
hl(0, 'LspReferenceText', { bg = 'none', bold = true })
hl(0, 'Comment', { bg = 'none', fg = '#777777', italic = true })
hl(0, 'Keyword', { italic = true })
hl(0, 'Identifier', { italic = true, bold = true })
hl(0, 'StorageClass', { italic = true })
hl(0, 'jsLineComment', { italic = true })
hl(0, 'xmlAttrib', { italic = true })
hl(0, 'htmlArg', { italic = true })
hl(0, 'pythonSelf', { italic = true })
hl(0, 'CmpItemKindCopilot', { italic = true, fg = '#6CC644' })
hl(0, 'DiagnosticLineNrError', { fg = '#FF0000', bold = true, bg = '#51202A' })
hl(0, 'DiagnosticLineNrWarn', { fg = '#FFA500', bold = true, bg = '#51412A' })
hl(0, 'DiagnosticLineNrInfo', { fg = '#00FFFF', bold = true, bg = '#1E535D' })
hl(0, 'DiagnosticLineNrHint', { fg = '#0000FF', bold = true, bg = '#1E205D' })
hl(0, 'CmpItemAbbrMatch', { fg = 'NONE', bg = '#000000' })

vim.cmd [[
  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]
