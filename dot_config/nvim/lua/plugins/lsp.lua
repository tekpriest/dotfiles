return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      diagnostics = {
        underline = false,
        virtual_text = false,
      },
      codelens = { enabled = false },
      inlay_hints = { enabled = false },
    },
  },
}
