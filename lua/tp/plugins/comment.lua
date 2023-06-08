return {
  {
    'numToStr/Comment.nvim',
    lazy = false,
    keys = { 'gcc', 'gbc' },
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'TodoTrouble', 'TodoTelescope', 'TodoQuickFix', 'TodoLocList' },
    config = function(_, opts)
      require('todo-comments').setup(opts)
    end,
  },
}
