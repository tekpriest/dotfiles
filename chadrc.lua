---@type ChadrcConfig
local M = {}
M.ui = {
  hl_override = {
    LspReferenceWrite = { bg = 'none', fg = 'none' },
    LspReferenceRead = { bg = 'none', fg = 'none' },
    LspReferenceText = { bg = 'none', fg = 'none' },
  },
  -- theme = 'aurora',
  transparency = true,
  statusline = {
    theme = 'vscode_colored',
    overriden_modules = function()
      return {
        mode = function()
          return ''
        end,
      }
    end,
  },
}

M.mappings = require 'custom.mappings'
M.plugins = 'custom.plugins'
return M
