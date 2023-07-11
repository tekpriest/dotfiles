return {
  -- {
  --   'numToStr/Comment.nvim',
  --   lazy = false,
  --   keys = { 'gcc', 'gbc' },
  --   config = true,
  -- },
  {
    'folke/todo-comments.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    event = 'BufReadPost',
    cmd = 'TodoTelescope',
    opts = {
      signs = false,
      gui_style = {
        bg = 'ITALIC',
      },
    },
  },
}
