local o, wo, bo, cmd, g = vim.opt, vim.wo, vim.bo, vim.cmd, vim.g
local indent, width = 2, 80

o.mouse = "a"
wo.number = true
wo.relativenumber = true
o.completeopt = { "menu", "menuone", "noselect" }
o.colorcolumn = tostring(width)
o.cursorline = true
o.expandtab = true
o.ignorecase = true
o.title = true
o.signcolumn = "yes"
o.inccommand = "nosplit"
o.hidden = true
o.pumheight = 5
o.smartcase = true
o.smartindent = true
o.breakindent = true
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.tabstop = indent
o.textwidth = width
o.updatetime = 100
o.wildmode = { "list", "longest" }
o.wildignore = { "node_modules/*" }
o.wrap = false
o.formatoptions = "crqnj"
o.scrolloff = 4
o.sidescrolloff = 5
o.shiftround = true
o.shiftwidth = indent
o.laststatus = 2
bo.swapfile = false
o.hlsearch = false
o.incsearch = true
o.showcmd = true
o.showmatch = true
o.softtabstop = indent
o.showmode = false
o.timeout = false
o.timeoutlen = 10
o.undofile = true
bo.undofile = true
o.clipboard = "unnamed,unnamedplus"
o.encoding = "utf-8"
o.backup = false
o.writebackup = false
o.cmdheight = 2
o.foldenable = true
o.wildmenu = true
o.background = "dark"
o.pumblend = 10
o.shiftwidth = indent
bo.shiftwidth = indent
o.shortmess:append("cI")
o.wrapscan = true
o.formatprg = "prettier --stdin-filepath=%"
o.syntax = "on"
o.spelllang = { "en" }
o.foldmethod = "expr"

cmd("filetype plugin indent on")
-- cmd 'colorscheme onedark'
cmd([[autocmd Colorscheme * highlight NormalFloat guibg=#1f2335]])
cmd([[autocmd Colorscheme * highlight FloatBorder guifg=white guibg=#1f2335]])
cmd([[command! Format execute 'lua vim.lsp.buf.formatting()']])

-- Map blankline
g.indent_blankline = "ø"
g.indent_blankline_filetype_exclude = { "help" }
g.indent_blankline_buftype_exclude = { "terminal", "nofile", "packer" }
g.indent_blankline_char_highlight = "LineNr"

-- Completion settings
g.UltiSnipsExpandTrigger = "<C-s>"
g.UltiSnipsListSnippets = "<c-l>"
g.UltiSnipsJumpForwardTrigger = "<c-b>"
g.UtliSnipsJumpBackwardTrigger = "<c-z>"
g.UltiSnipsEditSplit = "vertical"
