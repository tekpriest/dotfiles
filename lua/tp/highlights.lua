local hl = vim.api.nvim_set_hl

-- hl(0, 'Normal', { bg = 'none' })
-- hl(0, 'StatusLine', { bg = 'none' })
-- hl(0, 'StatusLineNC', { bg = 'none' })
-- hl(0, 'NormalNC', { bg = 'none', fg = 'none' })
-- hl(0, 'NonText', { bg = 'none' })
-- hl(0, 'SignColumn', { bg = 'none' })
-- hl(0, 'Structure', { bg = 'none' })
-- hl(0, 'LineNr', { bg = 'none', italic = true, fg = '#777777' })
-- hl(0, 'NormalFloat', { bg = 'none' })
hl(0, 'LspReferenceRead', { bg = 'none', bold = true, underline = false })
hl(0, 'LspReferenceWrite', { bg = 'none', bold = true, underline = false })
hl(0, 'LspReferenceText', { bg = 'none', bold = true, underline = false })
hl(0, 'Comment', { italic = true, fg = '#177c00', bg = 'none' })
hl(0, 'Keyword', { italic = true })
hl(0, 'Function', { italic = true })
hl(0, 'Identifier', { italic = true, bold = true })
hl(0, 'StorageClass', { italic = true })
hl(0, 'jsLineComment', { italic = true })
hl(0, 'xmlAttrib', { italic = true })
hl(0, 'htmlArg', { italic = true })
hl(0, 'pythonSelf', { italic = true })
-- hl(0, 'DiagnosticLineNrError', { fg = 'none', bg = '#51202A' })
-- hl(0, 'DiagnosticLineNrWarn', { fg = 'none', bg = '#51412A' })
-- hl(0, 'DiagnosticLineNrInfo', { fg = 'none', bg = '#1E535D' })
-- hl(0, 'DiagnosticLineNrHint', { fg = 'none', bg = '#1E205D' })
-- hl(0, 'CmpItemAbbrMatch', { fg = 'none', bg = '#000000' })
hl(0, 'NotifyBackground', { fg = 'none', bg = 'none' })

-- vim.cmd [[
--   sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
--   sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
--   sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
--   sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
-- ]]
