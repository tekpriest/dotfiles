return {
  'nvimtools/none-ls.nvim',
  event = 'VeryLazy',
  config = function()
    local null_ls = require 'null-ls'

    local sources = {
      -- code actions
      -- null_ls.builtins.code_actions.gomodifytags,
      -- null_ls.builtins.code_actions.impl,
      -- null_ls.builtins.code_actions.refactoring,

      -- diagnostics
      -- null_ls.builtins.diagnostics.revive,
      -- null_ls.builtins.diagnostics.hadolint,

      -- formatting
      -- null_ls.builtins.formatting.biome,
      -- null_ls.builtins.formatting.gofumpt,
      -- null_ls.builtins.formatting.goimports_reviser,
      null_ls.builtins.formatting.golines.with {
        extra_args = {
          '--max-len=100',
          '--base-formatter=gofumpt',
        },
      },
      -- null_ls.builtins.formatting.rustywind,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.mix,
    }

    null_ls.setup {
      sources = sources,
      debounce = 1000,
      default_timeout = 5000,
    }
  end,
}
