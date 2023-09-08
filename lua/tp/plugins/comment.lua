return {
  {
    'numToStr/Comment.nvim',
    lazy = false,
    keys = { 'gcc', 'gbc' },
    config = true,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    event = 'BufReadPost',
    cmd = { 'TodoTelescope', 'TodoTrouble' },
    keys = {
      {
        '<leader>ft',
        '<cmd>TodoTrouble<cr>',
        desc = 'toggle todos',
      },
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'next todo comment',
      },
      {
        '[t]',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'previous todo comment',
      },
    },
    opts = {
      signs = false,
      gui_style = {
        bg = 'ITALIC',
      },
    },
  },
}
