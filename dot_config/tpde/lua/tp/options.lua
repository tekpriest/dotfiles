local opt, o, g, fn = vim.opt, vim.o, vim.g, vim.fn

g.mapleader = ' '
g.maplocalleader = '\\'

o.mouse = ''
o.number = true
o.relativenumber = true
o.wrap = false
o.tabstop = 2
o.softtabstop = 2
o.shiftround = true
o.shiftwidth = 2
o.swapfile = false
o.termguicolors = true
o.signcolumn = 'yes'
o.winborder = 'rounded'
o.splitbelow = true
o.splitright = true
opt.cursorline = true
opt.cursorlineopt = 'number'
o.winborder = 'rounded'
opt.laststatus = 3
opt.showmode = false
opt.hlsearch = false
opt.incsearch = true
opt.showcmd = false
g.have_nerd_font = true
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
-- Decrease update time
vim.o.updatetime = 250
-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300
vim.o.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
vim.o.cmdheight = 1
vim.o.icm = 'split'
vim.o.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l%c:%m' }
vim.o.winblend = 30
vim.o.pumblend = 30
vim.o.pumheight = 5

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

  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
  local change_scale = function(delta)
    g.neovide_scale_factor = g.neovide_scale_factor * delta
  end

  vim.keymap.set('n', '<C-+>', function()
    change_scale(1.25)
  end)

  vim.keymap.set('n', '<C-->', function()
    change_scale(1 / 1.25)
  end)

  vim.keymap.set('n', '<C-=>', function()
    g.neovide_scale_factor = 1.0
  end)
end
