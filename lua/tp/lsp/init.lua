local ok, _ = pcall(require, 'lspconfig')
if not ok then
  return
end

local dev_ok, dev = pcall(require, 'neodev')
if not dev_ok then
  return
end
local lspconfig = require 'lspconfig'

-- load neodev
dev.setup {}

require('tp.lsp.setup').setup()

local servers = {
  bashls = {},
  cssls = {},
  docker_compose_language_service = {},
  dockerls = {},
  emmet_ls = {},
  html = {},
  jsonls = {
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
    end,
    settings = {
      json = {
        format = {
          enable = true,
        },
        validate = { enable = true },
      },
    },
    setup = {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line '$', 0 })
          end,
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Both',
          workspaceWord = true,
        },
        diagnostics = {
          enable = true,
          globals = { 'vim' },
        },
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
      },
    },
  },
  marksman = {},
  prismals = {},
  svelte = {},
  tailwindcss = {},
  taplo = {},
  terraformls = {},
  tsserver = {},
  yamlls = {
    settings = {
      yaml = { keyOrdering = false },
    },
  },
  ruff_lsp = {},
  bufls = {},
  sqlls = {},
  clangd = {},
}

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      on_attach = require('tp.lsp.setup').on_attach,
      capabilities = require('tp.lsp.setup').capabilities,
      settings = servers[server_name],
    }
  end,
}
