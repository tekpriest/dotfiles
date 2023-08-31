local lspconfig = require 'lspconfig'
local ts_ok, ts = pcall(require, 'typescript')
if not ts_ok then
  return
end
ts.setup {
  disable_commands = false,
  debug = false,
  go_to_source_definition = {
    fallback = true,
  },
  server = {
    on_attach = require('tp.lsp.setup').on_attach,
    capabilities = require('tp.lsp.setup').capabilities,
    root_dir = lspconfig.util.root_pattern 'package.json',
    settings = {
      completions = {
        completeFunctionCalls = true,
      },
    },
  },
}
