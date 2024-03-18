return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'elixir',
        'heex',
        'eex',
      })
    end,
  },
  -- {
  --   'elixir-tools/elixir-tools.nvim',
  --   version = '*',
  --   event = { 'BufReadPre', 'BufNewFile' },
  --   config = function()
  --     local elixir = require 'elixir'
  --     local elixirls = require 'elixir.elixirls'
  --
  --     elixir.setup {
  --       nextls = { enable = true },
  --       credo = {},
  --       elixirls = {
  --         enable = true,
  --         settings = elixirls.settings {
  --           dialyzerEnabled = true,
  --           enableTestLenses = true,
  --           fetchDeps = true,
  --           suggestSpecs = true,
  --         },
  --       },
  --     }
  --   end,
  -- },
}
