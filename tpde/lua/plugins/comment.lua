return {
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    -- keys = {
    --   { 'gc', mode = { 'n', 'v' } },
    --   { 'gcc', mode = { 'n', 'v' } },
    --   { 'gbc', mode = { 'n', 'v' } },
    -- },
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
        function() require('todo-comments').jump_next() end,
        desc = 'next todo comment',
      },
      {
        '[t',
        function() require('todo-comments').jump_prev() end,
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
  { -- surround
    'kylechui/nvim-surround',
    keys = {
      { 'ys', desc = '󰅪 Add Surround Operator' },
      { 'S', mode = 'x', desc = '󰅪 Add Surround Operator' },
      { 'yS', 'ys$', desc = '󰅪 Surround to EoL', remap = true },
      { 'ds', desc = '󰅪 Delete Surround Operator', mode = { 'n', 'v' } },
      { 'cs', desc = '󰅪 Change Surround Operator', mode = { 'n', 'v' } },
    },
    opts = {
      move_cursor = false,
      -- aliases = u.textobjRemaps,
      keymaps = {
        visual = 'S',
        normal_line = false,
        normal_cur_line = false,
        visual_line = false,
        insert_line = false,
        insert = false,
      },
      surrounds = {
        invalid_key_behavior = { add = false, find = false, delete = false, change = false },
        -- `dsl` -> delete surrounding call
        -- (includes : for lua methods and css pseudo-classes)
        ['l'] = {
          find = '[%w.:]+%b()',
          delete = '([%w.:]+%()().-(%))()',
        },
        ['R'] = { -- wikilink
          find = '%[%[.-%]%]',
          add = { '[[', ']]' },
          delete = '(%[%[)().-(%]%])()',
          change = {
            target = '(%[%[)().-(%]%])()',
          },
        },
        ['/'] = { -- regex
          find = '/.-/',
          add = { '/', '/' },
          delete = '(/)().-(/)()',
          change = {
            target = '(/)().-(/)()',
          },
        },
      },
    },
  },
}
