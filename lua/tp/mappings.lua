local map = vim.api.nvim_set_keymap

vim.g.mapleader = ' '

--Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- If I visually select words and paste from clipboard, don't replace my
-- clipboard with the selected word, instead keep my old word in the
-- clipboard
vim.keymap.set('x', 'p', '"_dP')

-- clear hlsearch with escape
-- map('n', '<esc>', '<cmd>:nohl<cr>', opts)

vim.defer_fn(function()
  local opts = { silent = true, noremap = true }
  local api = vim.api

  local keymaps = {
    n = {
      ['q'] = '<nop>',
      ['Q'] = 'q',
      ['Y'] = 'yg$',
      ['<c-j>'] = '<C-w>j',
      ['<c-k>'] = '<C-w>k',
      ['<c-l>'] = '<C-w>l',
      ['<c-h>'] = '<C-w>h',
      -- ['k'] = "v:count == 0 ? 'gk' : 'k'",
      -- ['j'] = "v:count == 0 ? 'gj' : 'j'",
      ['>>'] = '>>_',
      ['<<'] = '<<_',
      ['<leader>tt'] = '<cmd>Twilight<cr>',
      ['<Up>'] = '<cmd>resize -2<cr>',
      ['<Down>'] = '<cmd>resize +2<cr>',
      ['<Left>'] = '<cmd>vertical resize -2<cr>',
      ['<Right>'] = '<cmd>vertical resize +2<cr>',
      ['<C-d>'] = '<C-d>zz',
      ['<C-u>'] = '<C-u>zz',
      ['<A-j>'] = ':m .+1<cr>==',
      ['<A-k>'] = ':m .-2<cr>==',
      ['<leader>pp'] = ':!t<cr>',
      -- ['p'] = '"_dP',
    },
    i = {
      ['jk'] = '<esc>',
      ['jj'] = '<esc>',
    },
    v = {},
    o = {},
    c = {},
    t = {},
  }

  for mode, mode_tbl in pairs(keymaps) do
    for lhs, rhs in pairs(mode_tbl) do
      api.nvim_set_keymap(mode, lhs, rhs, opts)
    end
  end
end, 10)
