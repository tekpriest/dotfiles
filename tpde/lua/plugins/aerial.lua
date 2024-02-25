return {
  {
    'stevearc/aerial.nvim',
    event = 'VeryLazy',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.keymap.set('n', '<leader>cs', '<cmd>AerialToggle<cr>') end,
    config = function() require('aerial').setup() end,
    -- keys = {
    --   '<leader>cs',
    --   '<cmd>AerialToggle<cr>',
    --   desc = 'Toggle Aerial',
    -- },
  },
}
