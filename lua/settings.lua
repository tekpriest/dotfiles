local o, wo, bo = vim.opt, vim.wo, vim.bo
local indent, width = 2, 80

vim.cmd 'colorscheme melange'
o.completeopt = {'menuone','noselect'}
o.colorcolumn = tostring(width)
o.cursorline = true
o.mouse = 'a'
o.expandtab = true
o.ignorecase = true
o.number = true
o.relativenumber=true
o.title = true
o.pastetoggle = '<F2>'
o.signcolumn = 'yes'
o.inccommand = 'nosplit'
o.hidden = true
o.list = true
o.pumheight = 5
o.smartcase = true
o.smartindent = true
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.tabstop = indent
o.textwidth = width
o.updatetime = 100
o.wildmode = {'list','longest'}
o.wrap = false
o.formatoptions = 'crqnj'
o.scrolloff = 4
o.sidescrolloff = 5
o.shiftround = true
o.shiftwidth = indent
o.shortmess = 'c'
o.laststatus = 2
o.swapfile = true
o.dir = '/tmp'
o.hlsearch = true
o.incsearch = true
o.showcmd = true
o.showmatch = true
o.ruler = true
o.softtabstop = indent
o.showmode = false
o.timeout = false
o.timeoutlen = 10
o.undofile = true; bo.undofile = true
o.path = o.path + '.,**'
o.clipboard = 'unnamed,unnamedplus'

vim.cmd 'filetype plugin indent on'
vim.notify = require('notify')

