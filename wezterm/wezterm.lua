local wezterm = require 'wezterm'
local act = wezterm.action
local plugin = wezterm.plugin

local M = require('wezterm').config_builder and require('wezterm').config_builder() or {}

-- local workspace_switcher =
  -- plugin.require 'https://github.com/MLFlexer/smart_workspace_switcher.wezterm'
-- local tabline = plugin.require 'https://github.com/michaelbrusegard/tabline.wez'
--
-- tabline.setup {
--   options = {
--     theme = 'Tokyo Night',
--   },
--   extensions = { 'resurrect', 'smart_workspace_switcher' },
-- }

require('options').apply_to_config(M)
require('font').apply_to_config(M)
require('keys').apply_to_config(M)
require 'plugins'

-- tabline.apply_to_config(M)

-- keys
-- workspace_switcher.zoxide_path = '/opt/homebrew/bin/zoxide'
-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
  table.insert(M.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = act.ActivateTab(i - 1),
  })
end

M.key_tables = {
  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  },
  move_tab = {
    { key = 'h', action = act.MoveTabRelative(-1) },
    { key = 'j', action = act.MoveTabRelative(-1) },
    { key = 'k', action = act.MoveTabRelative(1) },
    { key = 'l', action = act.MoveTabRelative(1) },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  },
}

wezterm.plugin.require('https://gitlab.com/xarvex/presentation.wez').apply_to_config(M, {
  font_size_multiplier = 1.8, -- sets for both "presentation" and "presentation_full"
  presentation = {
    keybind = { key = 'p', mods = 'LEADER|SHIFT' }, -- setting a keybind
  },
  presentation_full = {
    font_weight = 'Bold',
    font_size_multiplier = 2.4, -- overwrites "font_size_multiplier" for "presentation_full"
  },
})

M.default_prog = { '/bin/zsh', '-l', '-c', 'tmux attach || tmux' }

return M
