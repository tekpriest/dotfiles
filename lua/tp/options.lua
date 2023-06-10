local opt, g, fn = vim.opt, vim.g, vim.fn

opt.nu = true
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
-- opt.signcolumn = 'yes'
-- opt.isfname:append '@-@'
opt.updatetime = 30
opt.splitright = true
opt.splitbelow = true
opt.textwidth = 80
opt.showcmd = false
-- opt.titleold = vim.fn.fnamemodify(vim.loop.os_getenv 'SHELL', ':t')
-- opt.titlestring = ' ❐ %t %r %m - ' .. fn.fnamemodify(fn.getcwd(), ':t')
-- opt.title = true
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
opt.wildignore =
  '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**'
opt.shortmess:append 'c'
opt.shiftround = true
opt.fillchars = {
  vert = '▕', -- alternatives │
  fold = ' ',
  eob = ' ', -- suppress ~ at EndOfBuffer
  diff = '░', -- alternatives = ⣿ ░ ─
  msgsep = '‾',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}
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
-- opt.sessionoptions = 'globals,buffers,curdir,help,winpos,folds,cursor,slash,unix'
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
opt.laststatus = 0
vim.cmd [[set statusline=%{repeat('─',winwidth('.'))}]]

g.mapleader = ' '
opt.updatecount = 0
opt.history = 1000
-- show the results of substitutions incrementally but don't split
opt.inccommand = 'nosplit'
opt.backspace = { 'indent', 'eol', 'start' }
opt.mouse = 'a'
table.insert(opt.diffopt, 'vertical')
table.insert(opt.diffopt, 'iwhite')
table.insert(opt.diffopt, 'internal')
table.insert(opt.diffopt, 'algorithm:patience')
table.insert(opt.diffopt, 'hiddenoff')

if fn.executable 'rg' then
  opt.grepprg = 'rg --hidden --vimgrep --no-heading --smart-case --'
  opt.grepformat = '%f:%l:%c:%m'
end

vim.cmd [[colorscheme kanagawa]]
