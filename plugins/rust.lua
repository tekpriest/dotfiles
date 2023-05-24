return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'rust-analyzer',
      },
      automatic_installation = true,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'rust',
        'toml',
      },
    },
  },
  {
    'simrat39/rust-tools.nvim',
    ft = { 'rust' },
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    opts = {
      server = {
        on_attach = function(client, bufnr)
          require('navigator.lspclient.mapping').setup {
            client = client,
            bufnr = bufnr,
          }
        end,
      },
    },
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end,
  },
  {
    'saecki/crates.nvim',
    init = function()
      vim.api.nvim_create_autocmd('BufRead', {
        group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
        pattern = 'Cargo.toml',
        callback = function()
          require('cmp').setup.buffer { sources = { { name = 'crates' } } }
          require 'crates'
        end,
      })
    end,
    opts = {
      null_ls = {
        enabled = true,
        name = 'crates.nvim',
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    opts = function()
      local M = require 'plugins.configs.cmp'
      table.insert(M.sources, { name = 'crates' })
      return M
    end,
  },
}
