return {
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'kanagawa',
    },
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    init = function()
      vim.cmd 'highlight! HarpoonInactive guibg=NONE guifg=#63698c'
      vim.cmd 'highlight! HarpoonActive guibg=NONE guifg=white'
      vim.cmd 'highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7'
      vim.cmd 'highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7'
      vim.cmd 'highlight! TabLineFill guibg=NONE guifg=white'
    end,
    keys = {
      {
        '<leader>ja',
        '<cmd>lua require("harpoon.mark").add_file()<cr>',
        desc = 'hook file',
      },
      {
        '<leader>jl',
        '<cmd>Telescope harpoon marks<cr>',
        desc = 'toggle harpoon menu',
      },
      {
        '<leader>jc',
        '<cmd>lua require("harpoon.mark").claer_all()<cr>',
        desc = 'clear harpoon menu',
      },
    },
  },
}
