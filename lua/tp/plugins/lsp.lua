return {
  {
    'jose-elias-alvarez/null-ls.nvim',
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim', config = true },
      'williamboman/mason.nvim',
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {
          text = {
            spinner = 'dots_footsteps',
          },
        },
      },
      'folke/neodev.nvim',
    },
  },
}
