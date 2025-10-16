return {
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
			-- stylua: ignore start
      {']t', function() require('todo-comments').jump_next() end, { desc = 'next todo comment' }},
      {'[t', function() require('todo-comments').jump_prev() end, { desc = 'previous todo comment' }},
      -- stylua: ignore end
    },
  },
}
