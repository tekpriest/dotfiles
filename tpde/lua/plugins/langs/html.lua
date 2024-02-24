return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { 'html', 'css' }) end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { 'prettierd' }) end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      -- make sure mason installs the server
      servers = {
        -- html
        html = {
          filetypes = { 'html', 'templ' },
        },
        -- Emmet
        emmet_ls = {
          init_options = {
            html = {
              options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ['bem.enabled'] = true,
              },
            },
          },
        },
        -- CSS
        cssls = {
          settings = {
            css = {
              format = {
                enable = true,
                -- BUG this config is being ignored. Leaving in case of css-lsp-update
                -- preserveNewLines = true,
                -- maxPreserveNewLines = 2,
                -- spaceAroundSelectorSeparator = true,
              },
              lint = {
                vendorPrefix = 'ignore',
                duplicateProperties = 'warning',
                zeroUnits = 'warning',
              },
            },
          },
        },
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      defaults = {
        ['<leader>z'] = { name = '+System' },
        ['<leader>zC'] = { name = '+Color' },
      },
    },
  },
}
