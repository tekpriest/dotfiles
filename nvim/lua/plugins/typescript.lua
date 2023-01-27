require('typescript').setup {
  disable_commands = false,
  server = {
    on_attach = require('lsp').default_on_attach,
    capabilities = require('lsp').default_capabilities,
    root_dir = require('lspconfig').util.root_pattern 'package.json',
  },
}
