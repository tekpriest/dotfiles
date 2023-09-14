local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
  return
end

local servers = {
  'bashls',
  'cssls',
  'docker_compose_language_service',
  'dockerls',
  'emmet_ls',
  'gopls',
  'html',
  'jsonls',
  'lua_ls',
  'marksman',
  'prismals',
  'svelte',
  'tailwindcss',
  'taplo',
  'terraformls',
  'tsserver',
  'yamlls',
  'pyright',
  'ruff_lsp',
  'bufls',
}

-- local mason = require 'mason'
-- local masonconf = require 'mason-lspconfig'

-- setup mason
require('mason').setup {
  ui = {
    border = 'rounded',
  },
} -- load mason before everything

-- masonconf.setup {
--   ensure_installed = servers,
--   automatic_installation = true,
-- }

for _, server in pairs(servers) do
  local opts = {
    on_attach = require('tp.lsp.setup').on_attach,
    capabilities = require('tp.lsp.setup').capabilities,
  }

  -- incase a language server has @ in its name or starts with @ ???
  server = vim.split(server, '@')[1]

  local conf_ok, conf_opts = pcall(require, 'tp.lsp.settings.' .. server)
  if conf_ok then
    opts = vim.tbl_deep_extend('force', conf_opts, opts)
  end

  if server == 'tsserver' then
    require 'tp.lsp.tsserver'
  else
    lspconfig[server].setup(opts)
  end
end
