vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local opt = vim.opt

opt.termguicolors = true
opt.encoding = 'utf-8'
opt.backup = false
opt.swapfile = false
opt.wrap = false
opt.clipboard = 'unnamedplus'
opt.completeopt = 'menu,menuone,noselect'
opt.expandtab = true
opt.formatoptions = 'jcroqlnt'
opt.ignorecase = true
opt.inccommand = 'nosplit'
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.showmode = false
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
opt.laststatus = 0
opt.cursorline = true
opt.grepformat = '%f:%l:%c:%m'
opt.conceallevel = 3
opt.grepprg = 'rg --vimgrep'
opt.list = true
opt.listchars = {
  tab = '│.',
  extends = '›',
  precedes = '‹',
  trail = '•',
}
opt.pumblend = 10
opt.pumheight = 10
opt.hlsearch = false
opt.tabstop = 2
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.wildmode = 'longest:full,full'
opt.winminwidth = 5
opt.splitkeep = 'screen'
opt.copyindent = true
opt.incsearch = true
opt.hidden = true
opt.wildignore =
  '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**,*.swp,*.bak,*.pyc,*.class'
opt.fillchars:append {
  fold = ' ',
  horiz = '━', -- '▃',--'═', --'─',
  horizup = '┻', -- '╩',-- '┴',
  horizdown = '┳', -- '╦', --'┬',
  vert = '┃', -- '▐', --'║', --'┃',
  vertleft = '┨', -- '╣', --'┤',
  vertright = '┣', -- '╠', --'├',
  verthoriz = '╋', -- '╬',--'┼','
  eob = ' ', -- suppress ~ at EndOfBuffer
  diff = '⣿', -- alternatives = ⣿ ░ ─
  msgsep = '‾',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
  -- diff = "╲"
}
opt.autoread = true
opt.infercase = true
opt.titlestring = " ❐ %t %r %m - %(%{expand('%:~:.:h\\')}%)%(\\ %a%)"
-- opt.titleold = vim.fn.fnamemodify(vim.loop.os_getenv 'SHELL', ':t')
opt.title = true
opt.titlelen = 70
opt.breakat = [[\ \ ;:,!?]]
opt.textwidth = 80
opt.showcmd = false
opt.laststatus = 3

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0
