local M = {}

M.setup = function(lsp, config)
  lsp.gopls.setup {
    cmd = { 'gopls', 'serve' },
    filetypes = { 'go', 'gomod' },
    root_dir = lsp.util.root_pattern('go.work', 'go.mod', '.git'),
    capabilities = config.capabilities,
    on_attach = config.on_attach,
    -- on_attach = function(client, bufnr)
    --   client.server_capabilities.documentFormattingProvider = false
    --   client.server_capabilities.documentRangeFormattingProvider = false
    --   config.on_attach(client, bufnr)
    -- end,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  }
end

require('go').setup {}

return M
