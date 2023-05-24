---@type ChadrcConfig
local M = {}

local highlights = require 'custom.highlights'
local ui = require 'custom.ui'

M.ui = {
  hl_override = highlights.override,
  hl_add = highlights.add,
  -- theme = 'aurora',
  transparency = true,
  statusline = ui.statusline,
}

M.mappings = require 'custom.mappings'
M.plugins = 'custom.plugins'
return M
