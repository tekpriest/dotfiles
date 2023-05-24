local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt

opt.textwidth = 80
opt.hlsearch = false
opt.showcmd = false
opt.wrap = false
opt.titlestring = " ❐ %t %r %m - %(%{expand('%:~:.:h\\')}%)%(\\ %a%)"
opt.title = true
opt.completeopt = { 'noselect', 'noinsert', 'menu' }

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
