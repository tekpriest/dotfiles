vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])
vim.api.nvim_command [[autocmd CursorHold * lua require'tp.utils'.gitlens()]]
vim.api.nvim_command [[autocmd CursorMoved * lua require'tp.utils'.clearGitLens()]]
vim.api.nvim_command [[autocmd CursorMovedI * lua require'tp.utils'.clearGitLens()]]
