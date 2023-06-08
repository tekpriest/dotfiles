local api = vim.api
local autocmd = api.nvim_create_autocmd

-- auto resize when resizing nvim window
autocmd('VimResized', {
  pattern = '*',
  command = 'tabdo wincmd =',
})

autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- set cursor to the last position when opening a buffer
autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- autosource tmux
autocmd('BufWritePost', {
  pattern = { '*tmux.conf' },
  command = "execute 'silent !tmux source <afile> --silent'",
})

-- autosource fish
autocmd('BufWritePost', {
  pattern = { 'config.fish' },
  command = "execute 'silent !source <afile> --silent'",
})

-- set .mdx and .md files to markdown
autocmd({ 'BufNewFile', 'BufFilePre', 'BufRead' }, {
  pattern = { '*.mdx', '*.md' },
  callback = function()
    vim.cmd [[set filetype=markdown wrap linebreak nolist nospell]]
  end,
})

-- set .conf files to sh
autocmd({ 'BufRead' }, {
  pattern = { '*.conf' },
  callback = function()
    vim.cmd [[set filetype=sh]]
  end,
})
