local g = vim.g
local o = vim.o
local opt = vim.opt
local fn = vim.fn

o.termguicolors = true
g.vimsyn_embed = 'lPr'
g.tex_flavor = 'latex'
o.encoding = 'utf-8'
o.modeline = true
o.mouse = 'a'
o.mousescroll = 'ver:1,hor:1'
o.errorbells = false
o.visualbell = false
o.history = 1000
o.undolevels = 1000
o.title = true
o.backup = false
o.swapfile = false
o.wrap = false
o.tabstop = 2
o.shiftwidth = o.tabstop
o.shiftround = true
o.expandtab = true
o.backspace = 'indent,eol,start'
o.autoindent = true
o.copyindent = true
o.number = true
o.relativenumber = true
o.showmatch = true
o.ignorecase = true
o.smartcase = true
o.smarttab = true
o.hlsearch = false
o.incsearch = true
o.hidden = true
o.wildignore =
  '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**,*.swp,*.bak,*.pyc,*.class'
o.wildmode = 'longest,full'
o.wildmenu = true
opt.wildoptions:append { 'pum' }
o.wildcharm = 26
o.wildignorecase = true
o.showcmd = false
o.showmode = false
o.sidescroll = 1
o.splitkeep = 'screen'
o.conceallevel = 2
o.completeopt = 'menuone,noinsert,noselect'
o.clipboard = 'unnamed,unnamedplus'
o.pumheight = 15
o.maxmempattern = 5000

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
o.inccommand = 'nosplit'
o.updatetime = 300
opt.shortmess:append { c = true }
o.signcolumn = 'yes:1'
o.splitright = true
o.splitbelow = true
o.foldenable = false
opt.jumpoptions:append { 'view' }
o.list = true -- set icons for lines
o.listchars = 'tab:│.,extends:›,precedes:‹,trail:•'
opt.diffopt:append { 'vertical', 'linematch:60', 'algorithm:histogram' }
o.undofile = true
-- o.undodir = $HOME/ .. ".vim/undo"
o.writebackup = false
o.autoread = true
o.infercase = true
o.timeout = true
o.timeoutlen = 300 -- Length of time to wait for a mapped sequence
o.ttimeoutlen = 10
-- o.titlestring = " ❐ %t %r %m - %(%{expand('%:~:.:h\\')}%)%(\\ %a%)"
-- o.titleold = vim.fn.fnamemodify(vim.loop.os_getenv 'SHELL', ':t')
-- o.title = true
-- o.titlelen = 70
o.grepprg = 'rg --hidden --vimgrep --smart-case --'
o.breakat = [[\ \ ;:,!?]]
o.textwidth = 80

function CustomFoldText()
  return fn.getline(vim.v.foldstart) .. ' ... ' .. fn.getline(vim.v.foldend):gsub('^%s*', '')
end

opt.foldtext = 'v:lua.CustomFoldText()'

vim.api.nvim_create_user_command('LoadNeovide', function()
  print 'hello neo'
end, { desc = 'Setup Neovide' })

vim.cmd [[let g:python3_host_prog = "/usr/local/bin/python3"]]

-- neovide settings
vim.cmd [[ if exists("g:neovide")
set guifont=VictorMono\ Nerd\ Font:h10.5
let g:neovide_floating_blur_amount_x = 2.0
let g:neovide_floating_blur_amount_y = 2.0
let g:neovide_hide_mouse_when_typing = v:true
let g:neovide_input_use_logo = v:true  " v:true on macOS
let g:neovide_cursor_animation_length=0.05
let g:neovide_cursor_trail_size = 0
let g:neovide_input_macos_alt_is_meta = v:true
]]
