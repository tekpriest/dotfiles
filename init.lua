local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt

opt.textwidth = 80
opt.hlsearch = false
opt.showcmd = false
opt.wrap = false
opt.titleold = vim.fn.fnamemodify(vim.loop.os_getenv 'SHELL', ':t')
opt.titlestring = " ❐ %t %r %m - %(%{expand('%:~:.:h\\')}%)%(\\ %a%)"
opt.title = true
opt.completeopt = { 'noselect', 'noinsert', 'menu' }
opt.list = true
opt.listchars = {
  eol = nil,
  tab = '│ ',
  extends = '›', -- Alternatives: … »
  precedes = '‹', -- Alternatives: … «
  trail = '•',  -- BULLET (U+2022, UTF-8: E2 80 A2)
}
opt.wildoptions = 'pum'
opt.wildmenu = true
opt.wildmode = 'longest:full,full'
opt.wildignorecase = true
opt.wildignore =
'.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**'
opt.shortmess:append 'aoOTIcF'
opt.shiftround = true
opt.fillchars = {
  vert = '▕', -- alternatives │
  fold = ' ',
  eob = ' ',  -- suppress ~ at EndOfBuffer
  diff = '░', -- alternatives = ⣿ ░ ─
  msgsep = '‾',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}
opt.formatoptions = {
  ['1'] = true,
  ['2'] = true, -- Use indent from 2nd line of a paragraph
  q = true,     -- continue comments with gq"
  c = true,     -- Auto-wrap comments using textwidth
  r = true,     -- Continue comments when pressing Enter
  n = true,     -- Recognize numbered lists
  t = false,    -- autowrap lines using text width value
  j = true,     -- remove a comment leader when joining lines.
  -- Only break if the line was not longer than 'textwidth' when the insert
  -- started and only at a white character that has been entered during the
  -- current insert command.
  l = true,
  v = true,
}
opt.foldenable = true
opt.foldlevelstart = 99
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_tresitter#foldexpr()'
opt.indentexpr = 'nvim_treesitter#indent()'
opt.virtualedit = 'block'
opt.sessionoptions =
'globals,buffers,curdir,help,winpos,folds,cursor,slash,unix'
vim.g.markdown_fenced_languages = {
  'js=javascript',
  'ts=typescript',
  'shell=sh',
  'bash=sh',
  'console=sh',
}
opt.synmaxcol = 3096
opt.spellsuggest:prepend { 12 }
opt.shada = "!,'300,<50,@100,s10,h"
opt.redrawtime = 1000
opt.complete = '.,w,b,k'
opt.grepprg = 'rg --hidden --vimgrep --smart-case --'
opt.breakat = [[\ \	;:,!?]]
opt.whichwrap = 'h,l,<,>,[,]'
opt.switchbuf = 'useopen'
opt.jumpoptions = 'stack'
opt.pumblend = 10
opt.winblend = 10

vim.cmd [[
  hi LspReferenceWrite guibg=bold cterm=bold guifg=bold
  hi LspReferenceText guibg=bold cterm=bold guifg=bold
  hi LspReferenceRead guibg=bold cterm=bold guifg=bold
]]

-- auto resize when resizing nvim window
autocmd('VimResized', {
  pattern = '*',
  command = 'tabdo wincmd =',
})

autocmd('TextYankPost', {
  pattern = '*',
  command = 'lua vim.highlight.on_yank()',
})

vim.g.indent_blankline_filetype_exclude = {
  'startify',
  'dashboard',
  'dotooagenda',
  'log',
  'fugitive',
  'gitcommit',
  'packer',
  'vimwiki',
  'markdown',
  'json',
  'txt',
  'vista',
  'help',
  'todoist',
  'NvimTree',
  'peekaboo',
  'git',
  'TelescopePrompt',
  'undotree',
  'flutterToolsOutline',
  '', -- for all buffers without a file type
}
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
  'class',
  'function',
  'method',
  'block',
  'list_literal',
  'selector',
  '^if',
  '^table',
  'if_statement',
  'while',
  'for',
}
