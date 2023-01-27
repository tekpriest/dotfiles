local M = {}

M.setup = function(lsp, config)
  lsp.pyright.setup {
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    flags = {
      allow_incremental_sync = true,
    },
    single_file_support = true,
    settings = {
      -- pyright = { completeFunctionParens = true },
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'workspace',
          useLibraryCodeForTypes = true,
          reportMissingTypeStubs = true,
          typeCheckingMode = 'on',
          -- stubsPath = "$HOME/typings"
        },
      },
    },
  }
end

return M
