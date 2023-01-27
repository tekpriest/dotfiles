local M = {}

M.setup = function(lsp, config)
  lsp.sumneko_lua.setup {
    capabilities = config.capabilities,
    on_attach = config.on_attach,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ";")
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
          checkThirdParty = false,
        },
        completion = {
          keywordSnippet = 'Replace',
          callSnippet = 'Replace',
        },
        telemetry = {
          enable = false,
        },
        hint = {
          enable = false,
        },
      },
    },
  }
end

return M
