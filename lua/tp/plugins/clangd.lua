return {
  'p00f/clangd_extensions.nvim',
  lazy = true,
  config = function() end,
  opts = {
    extensions = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
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
    },
  },
  keys = {
    {
      '<leader>cR',
      '<cmd>ClangdSwitchSourceHeader<cr>',
      desc = 'Switch Source/Header (C/C++)',
    },
  },
}
