return {
  -- comment
  {
    'echasnovski/mini.comment',
    version = '*',
    opts = {
      options = {
        ignore_blank_line = true,
      },
    },
  },

  -- line move
  {
    'echasnovski/mini.move',
    version = '*',
    config = function()
      require('mini.move').setup()
    end,
  },

  -- dashboard
  -- {
  --   'echasnovski/mini.starter',
  --   version = '*',
  --   opts = {
  --     header = 'Tech Priest',
  --     footer = 'Slime San',
  --     silent = true,
  --   },
  -- },

  -- indentscope
  {
    'echasnovski/mini.indentscope',
    version = '*',
    opts = {
      draw = {
        -- animation = require('mini.indentscope').gen_animation_none(),
      },
    },
  },
}
