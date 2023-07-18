local ok, clangd = pcall(require, 'clangd_extensions')
if not ok then
  return
end

clangd.setup {
  server = {
    on_attach = require('tp.lsp.setup').on_attach,
    capabilities = require('tp.lsp.setup').capabilities,
  },
  extensions = {
    autoSetHints = true,
    role_icons = {
      type = '',
      declaration = '',
      expression = '',
      specifier = '',
      statement = '',
      ['template argument'] = '',
    },

    kind_icons = {
      Compound = '',
      Recovery = '',
      TranslationUnit = '',
      PackExpansion = '',
      TemplateTypeParm = '',
      TemplateTemplateParm = '',
      TemplateParamObject = '',
    },
  },
}
