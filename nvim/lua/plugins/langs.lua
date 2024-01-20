return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        nginx_language_server = {},
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        prismals = {},
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        bashls = {},
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      -- make sure mason installs the server
      servers = {
        volar = {},
      },
    },
  },
}
