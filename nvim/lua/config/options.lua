local fn = vim.fn

tp.add_config("scrolloff", 4)
tp.add_config("sidescrolloff", 4)
tp.add_config("sidescroll", 1)
tp.add_config("encoding", "utf-8")
tp.add_config("termguicolors", true)
tp.add_config("mouse","a")
tp.add_config("wrap", false)
tp.add_config("swapfile", false)
tp.add_config("emoji", false)
tp.add_config("showmatch", false)
tp.add_config("ignorecase", true)
tp.add_config("smartcase", true)
tp.add_config("showmode", false)
tp.add_config("hidden", true)
tp.add_config("clipboard", "unnamedplus")
tp.add_config("list",true)
tp.add_config("wildmenu",true)
tp.add_config("tabstop", 2)
tp.add_config("softtabstop", 2)
tp.add_config("shiftwidth", 2)
tp.add_config("shiftround", true)
tp.add_config("expandtab", true)
tp.add_config("laststatus", 2)
tp.add_config("updatetime", 200)
tp.add_config("timeout", true)
tp.add_config("timeoutlen", 500)
tp.add_config("ttimeoutlen", 10)
tp.add_config("undofile",true)
tp.add_config("backup", false)
tp.add_config("writebackup", false)
if vim.fn.isdirectory(vim.o.undodir) == 0 then
	vim.fn.mkdir(vim.o.undodir, "p")
end
if fn.isdirectory(vim.o.directory) == 0 then
  tp.add_config("directory", fn.stdpath("data") .. "/swap//")
	fn.mkdir(vim.o.directory, "p")
end
tp.add_config("backspace","indent,eol,start")
tp.add_config("guicursor", {
	[[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
	[[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
	[[sm:block-blinkwait175-blinkoff150-blinkon175]],
})
tp.add_config("indentexpr", "nvim_treesitter#indent()")
tp.add_config("emoji",false)
tp.add_config("number",true)
tp.add_config("signcolumn","yes")
tp.add_config("numberwidth",1)

vim.g.clipboard = {
	name = "macOS-clipboard",
	copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
	paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
	cache_enabled = false,
}
-- vim.notify = require("notify")

-- vim.cmd('let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"')
-- vim.cmd('let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"')
vim.cmd([[colorscheme kanagawa]])

tp.add_config("shortmess", {
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
})

tp.add_config("listchars", {
	eol = nil,
	tab = "│ ",
	extends = "›", -- Alternatives: … »
	precedes = "‹", -- Alternatives: … «
	trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
})

tp.add_config("fillchars", {
	vert = "▕", -- alternatives │
	fold = " ",
	eob = " ", -- suppress ~ at EndOfBuffer
	diff = "╱", -- alternatives = ⣿ ░ ─
	msgsep = "‾",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
})
tp.add_config("diffopt", "vertical,iwhite,hiddenoff,foldcolumn:0,context:4,algorithm:histogram,indent-heuristic")
tp.add_config("formatoptions", {
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
})
tp.add_config('foldtext','v:lua.tp.folds()')
tp.add_config("foldopen", vim.opt.foldopen + "search")
tp.add_config("foldlevelstart", 3)
tp.add_config("foldmethod", "expr")
tp.add_config("foldexpr", "nvim_treesitter#foldexpr()")
vim.o.switchbuf = "useopen,uselast"
vim.o.grepprg = [[rg --glob "!.git", --no-heading --vimgrep --follow $*]]
tp.add_config("grepformat", vim.opt.grepformat ^ { "%f:%l%c%n" })
tp.add_config("wildcharm", vim.fn.char2nr(tp.replace_termcodes([[<Tab>]])))
tp.add_config("wildmode", "longest:full,full")
tp.add_config("wildignorecase", true)
tp.add_config("wildignore", {
  "*/cache/*",
  "*/tmp/*",
  "*/node_modules/*",
  "*.aux",
	"*.out",
	"*.toc",
	"*.o",
	"*.obj",
	"*.dll",
	"*.jar",
	"*.pyc",
	"*.rbc",
	"*.class",
	"*.gif",
	"*.ico",
	"*.jpg",
	"*.jpeg",
	"*.png",
	"*.avi",
	"*.wav",
  -- Temp/System
	"*.*~",
	"*~ ",
	"*.swp",
	".lock",
	".DS_Store",
	"tags.lock",
  "*.lock.*"
})
tp.add_config("wildoptions", "pum")
tp.add_config("pumblend", 3)
tp.add_config("synmaxcol", 1024)
tp.add_config("ruler", false)
tp.add_config("conceallevel", 2)
tp.add_config("breakindentopt", "sbr")
tp.add_config("signcolumn", "yes:1")
tp.add_config("cmdheight", 2)
vim.g.markdown_fenced_languages = {
  "js=javascript",
  "ts=typescript",
  "shell=sh",
  "bash=sh",
  "console=sh"
}

tp.add_config("textwidth", 80)
tp.add_config("autoindent", true)
tp.add_config("hlsearch", false)
tp.add_config("completeopt", { "menuone", "noselect" })
tp.add_config("pumheight", 15)
tp.add_config("joinspaces", false)
tp.add_config("gdefault", true)
tp.add_config("autowriteall", true)
tp.add_config("cursorlineopt", "screenline,number")
tp.add_config("sessionoptions", { "globals", "buffers", "curdir", "help", "winpos" })
tp.add_config("viewoptions", { "cursor", "folds" })
tp.add_config("virtualedit", "block")
vim.opt.spellsuggest:prepend({ 12 })
tp.add_config("spelloptions", "camel")
tp.add_config("spellcapcheck", "")
tp.add_config("fileformats", { "unix", "mac", "dos" })
tp.add_config("mousefocus", true)
tp.add_config("secure", true)
tp.add_config("exrc", true)
-- title
tp.add_config("title", true)
tp.add_config("titlestring", " ❐ %t %r %m")
tp.add_config("titleold", fn.fnamemodify(vim.loop.os_getenv("SHELL"), ":t"))
tp.add_config("titlelen", 65)

vim.g.mapleader = " "
vim.g.one_allow_italics = true
vim.g.oceanic_next_terminal_bold = true
vim.g.oceanic_next_terminal_italic = true
vim.g.gruvbox_italic = true
vim.g.vim_monokai_tasty_italic = true
vim.g.table_mode_corner = "|"
vim.g.markdown_fold_override_foldtext = false
vim.g.markdown_syntax_conceal = false
vim.g.mkdp_auto_start = false
vim.g.vim_json_syntax_conceal = false
vim.g.override_nvim_web_devicons = true
vim.g.dashboard_default_executive = "telescope"

