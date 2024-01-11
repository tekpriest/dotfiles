return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'rust' })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'rust-analyzer',
      })
    end,
  },
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    'simrat39/rust-tools.nvim',
    dependencies = 'neovim/nvim-lspconfig',
    ft = 'rust',
    opts = {
      server = {
        on_attach = require('core.utils').on_attach,
        capabilities = require('core.utils').capabilities(),
      },
    },
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end,
  },
}
