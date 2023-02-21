return {
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      {
        'saecki/crates.nvim',
        event = 'BufRead Cargo.toml',
        config = function()
          require('crates').setup {
            null_ls = { enabled = true },
          }
        end,
      },
    },
    opts = {
      servers = {
        rust_analyzer = {},
      },
    },
    config = true,
    --   function()
    --   local rt = require 'rust-tools'
    --   rt.setup {
    --     server = {
    --       on_attach = function(_, bufnr)
    --         vim.keymap.set('n', '<leader>ca', rt.hover_actions.hover_actions, { bufnr = bufnr })
    --         vim.keymap.set('n', 'gla', rt.code_action_group.code_action_group, { bufnr = bufnr })
    --       end,
    --     },
    --   }
    -- end,
  },
}
