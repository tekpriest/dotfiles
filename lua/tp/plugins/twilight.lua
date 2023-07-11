-- dim code blocks
return {
  'folke/twilight.nvim',
  cmd = { 'Twilight', 'TwilightEnable', 'TwilightDisable' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    ['<leader>tt'] = { '<cmd>Twilight<CR>', { desc = 'toggle twilight' } },
  },
}

-- vim: ts=2 sts=2 sw=2 et
