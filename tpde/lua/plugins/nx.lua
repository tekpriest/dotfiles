return {
  'Equilibris/nx.nvim',
  dependencies = { 'telescope.nvim' },
  config = function()
    require('nx').setup()
  end,
  keys = {
    {
      '<leader>na',
      '<cmd>Telescope nx actions<cr>',
      desc = 'show nx actions',
    },
    {
      '<leader>ng',
      '<cmd>Telescope nx generators<cr>',
      desc = 'show nx generators',
    },
  },
}
