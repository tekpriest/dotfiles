local opt = vim.opt

opt.textwidth = 80
opt.hlsearch = false
opt.showcmd = false
opt.wrap = false
opt.titlestring = " ❐ %t %r %m - %(%{expand('%:~:.:h\\')}%)%(\\ %a%)"
opt.title = true
-- opt.completeopt = { 'noselect', 'noinsert', 'menu' }
