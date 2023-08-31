local Utils = require 'tp.utils'
return {
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
    keys = {
      {
        '<leader>co',
        '<cmd>TypescriptOrganizeImports<CR>',
        desc = 'Organize Imports',
      },
      { '<leader>cR', '<cmd>TypescriptRenameFile<CR>', desc = 'Rename File' },
    },
  },
}
