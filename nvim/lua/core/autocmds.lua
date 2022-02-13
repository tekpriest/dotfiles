vim.api.nvim_command(
  "autocmd BufWritePre *.dart,*.rs lua vim.lsp.buf.formatting_sync()"
)
vim.api.nvim_command("autocmd BufWritePost *.lua so %")
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

vim.cmd([[
func! GodotSettings() abort
    setlocal foldmethod=expr
    setlocal tabstop=4
    nnoremap <buffer> <F4> :GodotRunLast<CR>
    nnoremap <buffer> <F5> :GodotRun<CR>
    nnoremap <buffer> <F6> :GodotRunCurrent<CR>
    nnoremap <buffer> <F7> :GodotRunFZF<CR>
endfunc
augroup godot | au!
    au FileType gdscript call GodotSettings()
augroup end
]])
-- update location list
-- vim.cmd([[
-- augroup LspLocationList
-- autocmd!
-- autocmd BufWritePre,BufEnter,InsertLeave * silent! lua vim.lsp.diagnostic.set_loclist({open_loclist=false})
-- ]])
