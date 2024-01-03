local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true, nowait = true }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

vim.defer_fn(function()
  local keys = {
    n = {
      -- Better viewing
      ['n'] = 'nzzzv',
      ['N'] = 'Nzzzv',
      ['g,'] = 'g,zvzz',
      ['g;'] = 'g;zvzz',
      -- Scrolling
      ['<C-u>'] = '<C-u>zz',
      ['<C-d>'] = '<C-d>zz',
      ['q'] = '<nop>',
      ['Q'] = 'q',
      ['Y'] = 'yg$',
      ['<c-j>'] = '<C-w>j',
      ['<c-k>'] = '<C-w>k',
      ['<c-l>'] = '<C-w>l',
      ['<c-h>'] = '<C-w>h',
      ['>>'] = '>>_',
      ['<<'] = '<<_',
      ['<Up>'] = '<cmd>resize -2<cr>',
      ['<Down>'] = '<cmd>resize +2<cr>',
      ['<Left>'] = '<cmd>vertical resize -2<cr>',
      ['<Right>'] = '<cmd>vertical resize +2<cr>',
      ['<TAB>'] = [[<cmd>tabnext<cr>]],
      ['<S-TAB>'] = [[<cmd>tabprevious<cr>]],
      ['<A-j>'] = ':m .+1<cr>==',
      ['<A-k>'] = ':m .-2<cr>==',
      ['<leader>n'] = [[<cmd>vsplit enew<cr>]],
      ['<leader>tn'] = [[<cmd>tabnew<cr>]],
      ['<leader>tc'] = [[<cmd>tabclose<cr>]],
      ['j'] = [[mzJ`z`]],
    },
    v = {
      -- Better indent
      ['>'] = '>gv',
      ['<'] = '<gv',
      ['<A-j>'] = [[:m '>+1<CR>gv=gv']],
      ['<A-k>'] = [[:m '<-2<CR>gv=gv']],
    },
    t = {
      ['jk'] = '<C-\\><C-n>',
    },
    i = {
      ['jk'] = '<ESC>',
      ['jj'] = '<ESC>',
      -- Add undo breakpoints
      [','] = ',<c-g>u',
      ['.'] = '.<c-g>u',
      [';'] = ';<c-g>u',
    },
    x = {
      ['p'] = '"_dP',
    },
  }

  for mode, mode_tbl in pairs(keys) do
    for lhs, rhs in pairs(mode_tbl) do
      map(mode, lhs, rhs, opts)
    end
  end

  -- Remap for dealing with word wrap
  vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
  vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

  -- Auto indent
  vim.keymap.set('n', 'i', function()
    if #vim.fn.getline '.' == 0 then
      return [["_cc]]
    else
      return 'i'
    end
  end, { expr = true })
end, 10)
