return {
  {
    'rest-nvim/rest.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {
      result_split_in_place = true,
      result = {
        show_curl_command = true,
      },
      jump_to_request = true,
    },
    config = function(_, opts)
      require('rest-nvim').setup(opts)
    end,
    keys = function()
      local rest = require 'rest-nvim'
      return {
        {
          '<leader>rx',
          rest.run,
          desc = 'run request under cursor',
        },
        {
          '<leader>rp',
          function()
            rest.run(true)
          end,
          desc = 'preview curl request under cursor',
        },
        {
          '<leader>rl',
          rest.last,
          desc = 'run last request',
        },
      }
    end,
  },
}
