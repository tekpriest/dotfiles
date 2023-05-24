return {
  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = true,
    event = 'BufRead package.json',
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'typescript-language-server',
        'prisma-language-server',
      },
      automatic_installation = true,
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- require
      require 'custom.configs.lsp'
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'javascript',
        'prisma',
        'tsx',
        'typescript',
      },
    },
  },
}
