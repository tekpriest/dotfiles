local on_attach = require('plugins.configs.lspconfig').on_attach
local capabilities = require('plugins.configs.lspconfig').capabilities
local lspconfig = require 'lspconfig'

-- init default lsp
require 'plugins.configs.lspconfig'

-- lspconfig.gopls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     gopls = {
--       completeUnimported = true,
--       usePlaceholders = true,
--       analyses = {
--         unusedparams = true,
--       },
--       buildFlags = { '-tags' },
--     },
--   },
-- }

-- lspconfig.rust_analyzer.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.taplo.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.dockerls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.prismals.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.sqlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.graphql.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- lspconfig.cmake.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

lspconfig.neocmake.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
