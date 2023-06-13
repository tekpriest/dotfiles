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
    config = function()
      require('typescript').setup {
        on_attach = Utils.on_attach,
      }
    end,
  },
}
