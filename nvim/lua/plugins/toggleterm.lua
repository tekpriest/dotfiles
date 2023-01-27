require('toggleterm').setup {
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
}

vim.keymap.set('n', '<C-\\>', '<cmd>ToggleTerm<CR>', {})
