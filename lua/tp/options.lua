local opt, g, fn = vim.opt, vim.g, vim.fn

g.mapleader = ' '

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
opt.undodir = os.getenv 'HOME' .. '/.vim.undodir'
opt.undofile = true
opt.clipboard = { 'unnamedplus', 'unnamed' }
opt.hlsearch = false
opt.incsearch = true
opt.termguicolors = true
opt.scrolloff = 8
-- opt.isfname:append '@-@'
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
opt.shortmess:append 'c'
opt.shiftround = true
opt.joinspaces = false
vim.opt.guicursor = [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]]
opt.fillchars = [[vert:│,horiz:─,diff:░,eob: ]]
--   diff = '░', -- alternatives = ⣿ ░ ─
--   msgsep = '‾',
--   foldopen = '▾',
--   foldsep = '│',
--   foldclose = '▸',
opt.formatoptions = {
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
opt.cmdheight = 0
opt.smartcase = true
opt.ignorecase = true
opt.autoindent = true
opt.linebreak = true
opt.hidden = true
opt.showmatch = true
opt.smarttab = true
opt.confirm = false
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
opt.concealcursor = 'nc'
opt.previewheight = 5
opt.synmaxcol = 500
opt.display = 'msgsep'
opt.modeline = false
opt.signcolumn = 'yes:1'
opt.timeoutlen = 400
opt.switchbuf = 'useopen,uselast'
opt.confirm = false
opt.ruler = false
opt.lazyredraw = false
-- opt.virtualedit = 'all'
opt.cindent = true
opt.shortmess = 'filnxtToOFWIcC'

table.insert(opt.diffopt, 'vertical')
table.insert(opt.diffopt, 'iwhite')
table.insert(opt.diffopt, 'internal')
table.insert(opt.diffopt, 'algorithm:patience')
table.insert(opt.diffopt, 'hiddenoff')

if fn.executable 'rg' then
  opt.grepprg = 'rg --hidden --vimgrep --no-heading --smart-case --'
  opt.grepformat = '%f:%l:%c:%m'
end

-- vim.cmd [[colorscheme rose-pine]]
vim.cmd [[colorscheme catppuccin]]

-- Skip some remote provider loading
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded = 1

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
