local set = vim.opt

set.fileencoding = "utf-8" -- File content encoding for the buffer
set.spelllang = "en" -- Support US english
set.mouse = "a" -- Enable mouse support
set.backup = false -- Disable making a backup file
set.expandtab = true -- Enable the use of space in tab
set.hidden = true -- Ignore unsaved buffers
set.hlsearch = false -- Don't highlight all the matches of search pattern
set.ignorecase = true -- Case insensitive searching
set.smartcase = true -- Case sensitivie searching
set.spell = false -- Disable spelling checking and highlighting
set.showmode = false -- Disable showing modes in command line
set.smartindent = true -- Do auto indenting when starting a new line
set.splitbelow = true -- Splitting a new window below the current one
set.splitright = true -- Splitting a new window at the right of the current one
set.swapfile = false -- Disable use of swapfile for the buffer
set.termguicolors = true -- Enable 24-bit RGB color in the TUI
set.undofile = true -- Enable persistent undo
set.writebackup = false -- Disable making a backup before overwriting a file
set.showmatch = false
set.list = true
set.listchars = {
  eol = nil,
  tab = "│ ",
  extends = "›", -- Alternatives: … »
  precedes = "‹", -- Alternatives: … «
  trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
}
set.wildoptions = "pum"
set.wildmenu = true
set.wildmode = "longest:full,full"
set.wildignorecase = true
set.wildignore = {
  "*/node_modules/*",
  "*/cache/*",
  "*/tmp/*",
  ".DS_Store",
}
set.number = true -- Show numberline
set.wrap = false -- Disable wrapping of lines longer than the width of window
set.showmode = false -- Disable showing modes in the command line
set.signcolumn = "yes" -- Always show the sign column
set.updatetime = 300 -- Length of time to wait before triggering the plugin
set.clipboard = "unnamedplus" -- Connection to the system clipboard
set.completeopt = { "menuone", "noselect" } -- Options for insert mode completion
set.number = true -- Show numberline
set.timeout = true
set.timeoutlen = 300 -- Length of time to wait for a mapped sequence
set.ttimeoutlen = 10
set.cmdheight = 1 -- Number of screen lines to use for the command line
set.shiftwidth = 2 -- Number of space inserted for indentation
set.tabstop = 2 -- Number of space in a tab
set.scrolloff = 4 -- Number of lines to keep above and below the cursor
set.conceallevel = 0 -- Show text normally
set.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor
set.sidescroll = 2
set.cursorline = true -- Highlight the text line of the cursor
set.numberwidth = 1
set.shortmess = {
  t = true,
  A = true,
  o = true,
  O = true,
  T = true,
  f = true,
  F = true,
  s = true,
  c = true,
  W = true,
}
set.laststatus = 2
set.softtabstop = 2
set.shiftround = true
set.backspace = "indent,eol,start"
set.fillchars = {
  vert = "▕", -- alternatives │
  fold = " ",
  eob = " ", -- suppress ~ at EndOfBuffer
  diff = "╱", -- alternatives = ⣿ ░ ─
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
}
set.formatoptions = {
  ["1"] = true,
  ["2"] = true, -- Use indent from 2nd line of a paragraph
  q = true, -- continue comments with gq"
  c = true, -- Auto-wrap comments using textwidth
  r = true, -- Continue comments when pressing Enter
  n = true, -- Recognize numbered lists
  t = false, -- autowrap lines using text width value
  j = true, -- remove a comment leader when joining lines.
  -- Only break if the line was not longer than 'textwidth' when the insert
  -- started and only at a white character that has been entered during the
  -- current insert command.
  l = true,
  v = true,
}
set.foldtext = "v:lua.tp.folds()"
set.foldopen:append({ "search" })
set.foldlevelstart = 3
set.foldmethod = "expr"
set.foldexpr = "nvim_tresitter#foldexpr()"
set.indentexpr = "nvim_treesitter#indent()"
set.ruler = false
set.autoindent = true
set.cursorlineopt = "screenline,number"
set.viewoptions = "cursor,folds"
set.virtualedit = "block"
set.titlestring = " ❐ %t %r %m - %(%{expand('%:~:.:h\\')}%)%(\\ %a%)"
set.titleold = vim.fn.fnamemodify(vim.loop.os_getenv("SHELL"), ":t")
set.title = true
set.titlelen = 70
set.sessionoptions = { "globals", "buffers", "curdir", "help", "winpos" }
set.spellsuggest:prepend({ 12 })
vim.g.markdown_fenced_languages = {
  "js=javascript",
  "ts=typescript",
  "shell=sh",
  "bash=sh",
  "console=sh",
}
set.synmaxcol = 1024

vim.cmd([[colorscheme kanagawa]])
