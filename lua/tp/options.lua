local options = {
	backup = false, -- disable creating backup file
	swapfile = false, -- disable use of swapfile for the buffer
	writebackup = false, -- disable creating a backup before overwritting a file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	fileencoding = "utf-8", -- file encoding when writing to a file
	hidden = true, -- ignore unsaved buffers
	mouse = "a", -- enable mouse support
	showmode = false, -- disable showing modes in command line (-- INSERT ---,...etc)
	termguicolors = true, -- enable 24-bit RGB colors in the TUI
	undofile = true, -- enable persisten undo across modified files
	completeopt = { "menuone", "noinsert", "noselect" }, -- options for insert mode completion
	wildoptions = "pum", --
	wildmenu = true,
	wildmode = "longest:full,full", --
	wildignorecase = true, --
	wildignore = {
		".git",
		".hg",
		".svn",
		"*.pyc",
		"*.o",
		"*.out",
		"*.jpg",
		"*.jpeg",
		"*png",
		"*.gif",
		"*.zip",
		"**/tmp/**",
		"*.DS_Store",
		"**/node_modules/**",
		"**/bower_modules/**",
	}, --
	concealcursor = "niv", --
	conceallevel = 0, -- so code ticks can be visible in markdown
	ignorecase = true, -- case insensitive searching
	smartcase = true, -- only sensitive search when the first search charater is case sensitive
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	timeout = true,
	timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
	ttimeoutlen = 10,
	pumheight = 10, -- pop up menu height
	showtabline = 0, -- always show tabs
	hlsearch = false, -- don't highlight all the matches of search pattern
	updatetime = 100, -- faster completion (4000ms default)
	wrap = false, -- disable wrapping of lines longer than the width of window
	list = true, --
	listchars = {
		eol = nil,
		tab = "│ ",
		extends = "›", -- Alternatives: … »
		precedes = "‹", -- Alternatives: … «
		trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
	},
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	shiftround = true,
	tabstop = 2, -- insert 2 spaces for a tab
	softtabstop = 2,
	number = true, -- show numberline
	laststatus = 3, -- use the same bufferline for all buffers
	showcmd = false, --
	infercase = true, --
	cmdheight = 1,
	scrolloff = 3,
	sidescrolloff = 8,
	numberwidth = 2,
	backspace = "indent,eol,start",
	titlestring = " ❐ %t %r %m - %(%{expand('%:~:.:h\\')}%)%(\\ %a%)",
	titleold = vim.fn.fnamemodify(vim.loop.os_getenv("SHELL"), ":t"),
	title = true,
	titlelen = 70,
	sessionoptions = "globals,buffers,curdir,help,winpos,folds,cursor,slash,unix",
	grepprg = "rg --hidden --vimgrep --smart-case --",
	breakat = [[\ \ ;:,!?]],
	whichwrap = "h,l,<,>,[,]",
	fillchars = {
		vert = "▕", -- alternatives │
		fold = " ",
		eob = " ", -- suppress ~ at EndOfBuffer
		diff = "░", -- alternatives = ⣿ ░ ─
		msgsep = "‾",
		foldopen = "▾",
		foldsep = "│",
		foldclose = "▸",
	},
	autoread = true, -- automatically reload buffer when changed outside of neovim
	switchbuf = "useopen",
	diffopt = "filler,internal,hiddenoff,algorithm:histogram,indent-heuristic",
	jumpoptions = "stack",
	ruler = false,
	shortmess = "aoOTIcF",
	cursorlineopt = "screenline,number",
	viewoptions = "cursor,folds",
	virtualedit = "block",
	textwidth = 80,
	linebreak = true,
	display = "lastline",
	smartindent = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Set italics
vim.cmd("hi Comment gui=italic guifg='#596c3d'")
vim.cmd("hi Keyword gui=italic")
vim.cmd("hi Identifier gui=italic")
vim.cmd("hi StorageClass gui=italic")
vim.cmd("hi jsLineComment gui=italic")
vim.cmd("hi xmlAttrib gui=italic")
vim.cmd("hi htmlArg gui=italic")
vim.cmd("hi pythonSelf gui=italic")
vim.cmd("hi! link GitLens Comment")

vim.g.markdown_fenced_languages = {
	"js=javascript",
	"ts=typescript",
	"shell=sh",
	"bash=sh",
	"console=sh",
}

local colorscheme = "kanagawa"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
