return {
  {
    'mrcjkb/haskell-tools.nvim',
    deependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope.nvim', optional = true },
    },
    branch = '2.x.x',
    init = function()
      vim.g.haskell_tools = {
        hls = {
          on_attach = function(client, bufnr, _)
            require('tp.utils').on_attach(client, bufnr)
          end,
        },
      }
    end,
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
  },
}
