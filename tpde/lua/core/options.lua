local opt, g, fn = vim.opt, vim.g, vim.fn

g.mapleader = ' '
g.maplocalleader = ' '

opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.undodir = fn.stdpath 'config' .. '/extras/undodir'
opt.undofile = true
opt.clipboard = { 'unnamedplus', 'unnamed' }
opt.hlsearch = false
opt.incsearch = true
opt.scrolloff = 8
opt.isfname:append '@-@'
opt.updatetime = 65
opt.splitright = true
opt.splitbelow = true
opt.textwidth = 80
opt.showcmd = false
opt.titleold = vim.fn.fnamemodify(vim.loop.os_getenv 'SHELL', ':t')
opt.titlestring = ' ❐ %t %r %m - ' .. fn.fnamemodify(fn.getcwd(), ':t')
opt.title = true
opt.list = true
opt.listchars = {
  eol = nil,
  tab = '│ ',
  extends = '›', -- Alternatives: … »
  precedes = '‹', -- Alternatives: … «
  trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}
opt.wildoptions = 'pum'
opt.wildmenu = true
opt.wildmode = 'longest:full,full'
opt.wildignorecase = true
opt.wildignore = {
  '.git',
  '.hg',
  '.svn',
  '*.pyc',
  '*.o',
  '*.out',
  '*.jpg',
  '*.jpeg',
  '*.png',
  '*.gif',
  '*.zip',
  '**/tmp/**',
  '**/.DS_Store',
  '**/.hg',
  '**/.idea',
  '**/.next',
  '**/.svn',
  '**/CVS',
  '**/node_modules/*/**',
  '**/bower_modules/**',
  'package-lock.json',
  'vendor',
  'yarn.lock',
  'zig-cache',
}
-- opt.shortmess:append 'aoOWtIF'
opt.shortmess:append { W = true, I = true, c = true, C = true, s = true, F = true }
opt.shiftround = true
vim.o.fillchars = table.concat({
  'eob: ',
  'horiz:─',
  -- 'fold:╌',
  -- 'horiz:═',
  -- 'horizdown:╦',
  -- 'horizup:╩',
  -- 'vert:║',
  -- 'verthoriz:╬',
  -- 'vertleft:╣',
  -- 'vertright:╠',
  'vert:▕', -- alternatives │
  'fold: ',
  'diff:░', -- alternatives = ⣿ ░ ─
  'msgsep:‾',
  'foldopen:▾',
  'foldsep:│',
  'foldclose:▸',
}, ',')
vim.o.listchars = table.concat({ 'extends:…', 'nbsp:␣', 'precedes:…', 'tab:> ' }, ',')
-- opt.fillchars = {
--   diff = '░', -- alternatives = ⣿ ░ ─
--   msgsep = '‾',
--   foldopen = '▾',
--   foldsep = '│',
--   foldclose = '▸',
--   eob = ' ',
-- }
opt.formatoptions = 'rqnl1j'
opt.sessionoptions = 'globals,buffers,curdir,winpos,folds,tabpages,winsize'
g.markdown_fenced_languages = {
  'js=javascript',
  'ts=typescript',
  'shell=sh',
  'bash=sh',
  'console=sh',
}
g.markdown_fenced_languages = {
  'js=javascript',
  'ts=typescript',
  'shell=sh',
  'bash=sh',
  'console=sh',
}
opt.pumblend = 10
opt.winblend = 10
opt.cmdheight = 1
opt.smartcase = true
opt.ignorecase = true
opt.autoindent = true
opt.linebreak = true
opt.hidden = true
opt.showmatch = false
opt.smarttab = true
opt.whichwrap:append 'h,l,<,>,[,]'
opt.pumheight = 10
opt.laststatus = 3
opt.showmode = false
opt.shada = [['20,<50,s10,h,/100]]
opt.updatecount = 0
opt.history = 1000
-- show the results of substitutions incrementally but don't split
opt.inccommand = 'nosplit'
opt.backspace = { 'indent', 'eol', 'start' }
opt.mouse = 'nivh'
opt.mousemodel = 'extend'
opt.synmaxcol = 500
opt.signcolumn = 'yes'
opt.timeoutlen = 400
opt.ruler = false
opt.cindent = true
opt.completeopt = 'menu,menuone,noselect'
opt.winwidth = 30
vim.o.breakindent = true
vim.o.termguicolors = true
opt.autowrite = true
opt.mousescroll = 'ver:25,hor:6'
opt.writebackup = false
opt.confirm = false
opt.cursorline = true
opt.cursorlineopt = 'number'
vim.cmd [[filetype plugin indent on]]

-- table.insert(opt.diffopt, 'vertical')
-- table.insert(opt.diffopt, 'iwhite')
-- table.insert(opt.diffopt, 'internal')
-- table.insert(opt.diffopt, 'algorithm:patience')
-- table.insert(opt.diffopt, 'hiddenoff')

-- if fn.executable 'rg' then
--   opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
--   opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
-- end

-- Skip some remote provider loading
for _, provider in pairs { 'node', 'perl', 'python3', 'ruby' } do
  g['loaded_' .. provider .. '_provider'] = 0
end

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  'loaded',
  'loaded_gzip',
  'loaded_man',
  'loaded_matchit',
  'loaded_matchparen',
  'loaded_shada_plugin',
  'loaded_tar',
  'loaded_tarPlugin',
  'loaded_zipPlugin',
  'loaded_zip',
  'loaded_netrwPlugin',
}

for i = 1, 10 do
  g[disabled_built_ins[i]] = 1
end
vim.g.codelens_enabled = true
