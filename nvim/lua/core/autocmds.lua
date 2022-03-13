-- vim.api.nvim_command(
-- "autocmd BufWritePre *.dart,*.rs lua vim.lsp.buf.formatting_sync()"
-- )
vim.api.nvim_command("autocmd BufWritePost *.lua so %")
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])
-- vim.api.nvim_command("autocmd BufWritePre * silent! :Format")
