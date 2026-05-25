-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt, g, o, fn = vim.opt, vim.g, vim.o, vim.fn

opt.cursorlineopt = 'number'
opt.autowrite = false -- Disable auto write
g.autoformat = false -- Disable auto format
opt.mouse = '' -- Disable mouse mode
opt.showcmd = false -- Don't show commands
o.winborder = 'rounded'
o.swapfile = false
o.backup = false
o.hlsearch = false
o.breakindent = true -- Enable break indent
opt.jumpoptions = 'view'
opt.linebreak = true -- Wrap lines at convenient points
opt.ruler = false -- Disable the default ruler
g.inlay_hints = false

if g.neovide then
  g.neovide_opacity = 0.8
  g.transparency = 0.8
  g.neovide_window_blurred = true
  g.neovide_hide_mouse_when_typing = true
  g.neovide_cursor_trail_size = 0.1
  g.neovide_cursor_vfx_mode = ''
  g.neovide_scroll_animation_length = 0.1
  g.neovide_scroll_animation_far_lines = 10
  g.neovide_detach_on_quit = 'always_quit'
  g.neovide_scale_factor = 1.0
  g.neovide_padding_top = 30
  opt.titleold = fn.fnamemodify(vim.loop.os_getenv 'SHELL', ':t')
  opt.titlestring = ' ❐ %t - ' .. fn.fnamemodify(fn.expand '%:p:h', ':t')
  opt.title = true
  o.guifont = 'DankMono Nerd Font Mono:h12'

  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  local change_scale = function(delta)
    g.neovide_scale_factor = g.neovide_scale_factor * delta
  end

  vim.keymap.set('n', '<C-+>', function() change_scale(1.25) end)

  vim.keymap.set('n', '<C-->', function() change_scale(1 / 1.25) end)

  vim.keymap.set('n', '<C-=>', function() g.neovide_scale_factor = 1.0 end)
end
