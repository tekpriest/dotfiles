return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { is_block_ui_break = true },
  keys = {
    {
      '<leader>ss',
      function()
        require('spectre').toggle()
      end,
      desc = 'toggle spectre',
    },
    {
      '<leader>sf',
      function()
        require('spectre').open_file_search { select_word = true }
      end,
      desc = 'seacrch current word in file',
    },
    {
      '<leader>sw',
      function()
        require('spectre').open_visual { select_word = true }
      end,
      desc = 'global seacrch current word',
      mode = { 'n' },
    },
    {
      '<leader>sw',
      function()
        require('spectre').open_visual {}
      end,
      desc = 'global seacrch current word',
      mode = { 'v', 'x' },
    },
  },
}
