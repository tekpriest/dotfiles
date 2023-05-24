return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'clang-format',
        'clangd'
      },
      automatic_installation = true,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'c', 'cpp', 'cmake'
      },
    },
  }
}
