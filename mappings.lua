local M = {}

M.general = {
  i = {
    ['jk'] = { '<esc>' },
    ['jj'] = { '<esc>' },
  },
  n = {
    ['q'] = { '<nop>' },
    ['Q'] = { '<nop>' },
    ['<leader><Space>'] = { '<cmd>Telescope find_files<CR>', 'find files' },
    ['<C-k>'] = { '<C-w>k', 'go window up' },
  },
}

M.comment = {
  plugin = true,
  n = {
    ['gc'] = {
      function()
        require('Comment.api').toggle.linewise.current()
      end,
      'toggle comment',
    },
  },
  v = {
    ['gc'] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      'toggle comment',
    },
  },
}

M.nvimtree = {
  plugin = true,
  n = {
    -- toggle
    ['<leader>e'] = { '<cmd>NvimTreeToggle<CR>', 'toggle nvimtree' },
    -- focus
    ['<leader>o'] = { '<cmd>NvimTreeFocus<CR>', 'focus nvimtree' },
  },
}

M.nvterm = {
  plugin = true,
  n = {
    -- toggle in normal mode
    ['<leader>tf'] = {
      function()
        require('nvterm.terminal').toggle 'float'
      end,
      'toggle floating term',
    },
  },
  t = {
    -- toggle in normal mode
    ['<leader>tf'] = {
      function()
        require('nvterm.terminal').toggle 'float'
      end,
      'toggle floating term',
    },
  },
}

M.lazygit = {
  -- plugin = true,
  n = { ['<leader>gg'] = { '<cmd>LazyGit<CR>', 'open git' } },
}

M.project = {
  -- plugin = true,
  n = {
    ['<leader>fp'] = { '<cmd>Telescope projects<CR>', 'open projects' },
  },
}

M.todo = {
  n = {
    ['<leader>tt'] = { '<cmd>TodoTelescope<CR>', 'open projects' },
  },
}

M.disabled = {
  n = {
    ['<leader>rn'] = '',
    ['<C-k>'] = '',
  },
}

return M
