local o = vim.o
local g = vim.g
local gn = vim.fn
local opt = vim.opt

-- apperance
o.termguicolors = true -- use terminal colors [important for themes]
g.vimsyn_embed='lPr'
g.tex_flavor='latex'
o.encoding = 'utf-8'
opt.number = true -- use line numbers
o.relativenumber = true -- use relative line numbers
o.mouse = 'a' -- allow for mouse usage for navigation
o.showmode = false -- don't show editing mode in the cmd
o.showcmd = false
o.smartindent = true -- use smart indent
o.expandtab = true -- allow for space in tabs
o.splitright = true -- split to the right
o.splitbelow = true -- split below
o.list = true -- set icons for lines
o.listchars = {
	eol = nil,
	tab = '│ ',
	extends = '›', -- Alternatives: … »
	precedes = '‹', -- Alternatives: … «
	trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}
o.wrap = false -- Disable wrapping of lines longer than the width of window
o.signcolumn = 'yes:1' -- Always show the sign column [used for diagnostics, gitsigns]
o.updatetime = 300 -- Length of time to wait before triggering the plugin
o.cmdheight = 1
o.shiftwidth = 2 -- Number of space inserted for indentation
o.tabstop = 2 -- Number of space in a tab
o.softtabstop = 2
o.scrolloff = 4 -- Number of lines to keep above and below the cursor
o.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor
o.conceallevel = 0 -- Show text normally
o.shortmess = o.shortmess + { c = true }
o.laststatus = 3
o.shiftround = true
o.backspace = 'indent,eol,start'
o.fillchars = {
	vert = '▕', -- alternatives │
	fold = ' ',
	eob = ' ', -- suppress ~ at EndOfBuffer
	diff = '⣿', -- alternatives = ⣿ ░ ─
	msgsep = '‾',
	foldopen = '▾',
	foldsep = '│',
	foldclose = '▸',
}
o.formatoptions = {
	['1'] = true,
	['2'] = true, -- Use indent from 2nd line of a paragraph
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
o.ruler = false
o.autoindent = true

-- buffers
o.undofile = true -- persist undo even on quit
o.hidden = true -- ignore unsaved buffers
o.clipboard = 'unnamed,unnamedplus' -- use system clipboard
o.writebackup = false -- disable backup on write
o.backup = false -- disable file backup
o.swapfile = false -- Disable use of swapfile for the buffer
o.autowrite = true

-- searching
o.hlsearch = false -- disable persist highlighting of search terms
o.ignorecase = true -- Case insensitive searching
o.smartcase = true -- Case sensitivie searching
o.infercase = true -- search based on first letter case in search term

-- wild opts
o.wildoptions = 'pum'
o.wildmenu = true
o.wildmode = 'longest:full,full'
o.wildignorecase = true
o.wildignore = {
	'.git',
	'.hg',
	'.svn',
	'*.pyc',
	'*.o',
	'*.out',
	'*.jpg',
	'*.jpeg',
	'*png',
	'*.gif',
	'*.zip',
	'**/tmp/**',
	'*.DS_Store',
	'**/node_modules/**',
	'**/bower_modules/**',
}
--'.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**'

o.timeout = true
o.timeoutlen = 300 -- Length of time to wait for a mapped sequence
o.ttimeoutlen = 10

-- title
o.titlestring = " ❐ %t %r %m - %(%{expand('%:~:.:h\\')}%)%(\\ %a%)"
o.titleold = vim.fn.fnamemodify(vim.loop.os_getenv 'SHELL', ':t')
o.title = true
o.titlelen = 70

-- editor
o.grepprg = 'rg --hidden --vimgrep --smart-case --'
o.breakat = [[\ \ ;:,!?]]
o.textwidth = 80
o.completeopt = { 'menuone', 'noselect', 'noinsert' }
-- o.foldmethod = 'syntax'
