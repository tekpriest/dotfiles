local map = vim.api.nvim_set_keymap

vim.g.mapleader = ' '
-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

local opts = { silent = true }

map('i', 'jk', '<esc>', opts)
map('i', 'jj', '<esc>', opts)

map('n', 'q', '<nop>', opts)
map('n', 'Q', 'q', opts)

map('v', '<A-j>', '>+1<CR>gv=gv', opts)
map('v', '<A-k>', '<-2<CR>gv=gv', opts)
map('n', '<A-j>', '<ESC><cmd>m .+1<CR>==', opts)
map('n', '<A-k>', '<ESC><cmd>m .+1<CR>==', opts)

map('n', 'Y', 'yg$', opts)
-- map('n', 'J', 'mzJ`z',opts)
-- map('n', '<C-d>', '<C-d>zz', opts)
-- map('n', '<C-u>', '<C-u>zz', opts)
-- map('n', 'n', 'nzzzv',opts)
-- map('n', 'N', 'Nzzzv',opts)
-- map('x', '<leader>p', '"_dP', opts)

-- format
map('n', '<leader>fm', [[<cCMD>lua vim.lsp.buf.format()<CR>]], opts)

-- neotree
map('n', '<leader>e', ':Neotree toggle<CR>', opts)
map('n', '<leader>o', ':Neotree reveal<CR>', opts)

-- lazygit
map('n', '<leader>gg', '<cmd>LazyGit<CR>', opts)

-- terraform
map('n', '<leader>ti', '<cmd>Terraform init<CR>', opts)
map('n', '<leader>tp', '<cmd>Terraform plan<CR>', opts)
map('n', '<leader>ta', '<cmd>Terraform apply<CR>', opts)
map('n', '<leader>td', '<cmd>Terraform destroy<CR>', opts)

-- session
-- restore the session for the current directory
map('n', '<leader>qs', [[<CMD>lua require('persistence').load()<CR>]], opts)
-- restore the last session
map(
  'n',
  '<leader>ql',
  [[ <CMD>lua require('persistence').load({last = true})<CR>]],
  opts
)
-- stop Persistence => session won't be saved on exit
map('n', '<leader>qd', [[<CMD>lua require('persistence').stop()<CR>]], opts)
