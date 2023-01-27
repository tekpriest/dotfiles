local on_attach = require('lsp').default_on_attach
local capabilities = require('lsp').default_capabilities
local lspconfig = require 'lspconfig'

local function make_config(server_name)
  local ok, config = pcall(require, 'lsp.servers.' .. server_name)
  if not ok then
    config = {}
  end
  local client_on_attach = config.on_attach
  -- wrap client-specific on_attach with default custom on_attach
  if client_on_attach then
    config.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client_on_attach(client, bufnr)
    end
  else
    config.on_attach = on_attach
  end
  config.capabilites = capabilities
  return config
end

require('lsp.servers.pyright').setup(lspconfig, make_config 'pyright')
require('lsp.servers.sumneko_lua').setup(lspconfig, make_config 'sumneko_lua')
require('lsp.servers.gopls').setup(lspconfig, make_config 'gopls')

local opts = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- lspconfig.tsserver.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.cssls.setup { opts }
lspconfig.prismals.setup { opts }
lspconfig.dockerls.setup { opts }
lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
lspconfig.cmake.setup { opts }
lspconfig.html.setup { opts }
lspconfig.bashls.setup { opts }
lspconfig.gdscript.setup { opts }
lspconfig.tailwindcss.setup {
  opts,
  -- capabilities = capabilities,
  -- on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern 'tailwind.config.js',
}
lspconfig.taplo.setup { opts }
lspconfig.omnisharp.setup { opts }
lspconfig.denols.setup {
  opts,
  -- capabilities = capabilities,
  -- on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
}
lspconfig.kotlin_language_server.setup {
  cmd = { '/usr/local/Cellar/kotlin-language-server/1.3.1/bin/kotlin-language-server' },
  opts,
  -- capabilities = capabilities,
  -- on_attach = on_attach,
}
