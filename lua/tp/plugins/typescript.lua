local Utils = require 'tp.utils'
return {
  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = true,
    event = 'BufRead package.json',
  },
  {
    'prisma/vim-prisma',
    ft = { 'prisma' },
  },
  {
    'jose-elias-alvarez/typescript.nvim',
    ft = {
      'typescript',
      'typescriptreact',
      'javascript',
      'javascriptreact',
    },
    -- config = function()
    --   local capabilities = require('cmp_nvim_lsp').default_capabilities()
    --
    --   require('typescript').setup {
    --     server = {
    --       on_attach = Utils.on_attach,
    --       capabilities = capabilities,
    --     },
    --   }
    -- end,
  },
}
