return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'gopls',
      },
      automatic_installation = true,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'go',
      },
    },
  },
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      verbose = true,
      lsp_cfg = {
        handlers = {
          ['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = 'double' }
          ),
          ['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = 'round' }
          ),
        },
      },
    },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go' },
    -- if you need to install/update all binaries
    build = ':lua require("go.install").update_all_sync()',
  },
}
