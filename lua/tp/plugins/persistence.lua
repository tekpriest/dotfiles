return {
  'folke/persistence.nvim',
  -- event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  opts = {},
  keys = {
    {
      '<leader>qs',
      function()
        require('persistence').load()
      end,
      desc = 'load sessions',
    },
  },
}
