local M = {}
function M.autocmd(event, triggers, operations)
  local cmd = string.format("autocmd %s %s %s", event, triggers, operations)
  vim.cmd(cmd)
end

-- M.autocmd("BufEnter", "*", "if &buftype == 'terminal' | :startinsert | endif")
-- M.autocmd("BufReadPost", "*", [[if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif]])
-- M.autocmd("BufWritePre", "*", "%s/\\s\\+$//e")
M.autocmd("ColorScheme", "*", "lua require('.utils.colors').setItalics()")
-- M.autocmd("CompleteDone", "*", "pclose")
-- M.autocmd("FileType", "vue", "syntax sync fromstart")
-- M.autocmd("WinLeave", "*", "if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif")
M.autocmd("BufWritePost", "*.lua", "luafile %")
M.autocmd("BufEnter", "*", "TwilightEnable")

vim.cmd([[
augroup highlight_yank
	autocmd!
	au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END
]])

return M
