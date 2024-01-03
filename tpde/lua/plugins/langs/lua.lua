return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'lua', 'luadoc', 'luap' })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'stylua' })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/neodev.nvim',
        opts = { library = { plugins = { 'nvim-dap-ui' }, types = true } },
      },
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.fn.expand '$VIMRUNTIME',
                },
              },
              completion = { callSnippet = 'Replace' },
              telemetry = { enable = false },
              hint = { enable = false },
              runtime = { version = 'LuaJIT' },
            },
          },
        },
      },
      setup = {
        lua_ls = function(_, _)
          local utils = require 'core.utils'
          utils.on_attach(function(client, buffer)
            -- stylua: ignore
            if client.name == 'lua_ls' then
              vim.keymap.set("n", "<leader>dX", function() require("osv").run_this() end,
                { buffer = buffer, desc = "OSV Run" })
              vim.keymap.set("n", "<leader>dL", function() require("osv").launch({ port = 8086 }) end,
                { buffer = buffer, desc = "OSV Launch" })
            end
          end)
        end,
      },
    },
  },
}
