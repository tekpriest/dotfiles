return {
  {
    enabled = false,
    'echasnovski/mini.completion',
    dependencies = {
      'echasnovski/mini.icons',
      'echasnovski/mini.snippets',
    },
    version = '*',
    opts = {
      mappings = {
        scroll_down = '<Down>',
        scroll_up = '<Up>',
      },
    },
  },
  {
    'echasnovski/mini.icons',
    opts = {},
  },
  {
    enabled = false,
    'echasnovski/mini.snippets',
    config = function()
      local gen_loader = require('mini.snippets').gen_loader
      require('mini.snippets').setup {
        snippets = {},
        mappings = {
          jump_next = '<Tab>',
          jump_prev = '<S-Tab>',
        },
      }
    end,
  },
  {
    'echasnovski/mini.clue',
    config = function()
      local miniclue = require 'mini.clue'
      miniclue.setup {
        triggers = {
          -- leader triggers
          { mode = 'n', keys = '<leader>' },
          { mode = 'x', keys = '<leader>' },

          -- built in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },

          -- Bracketed
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
        window = {
          delay = 100,
        },
      }
    end,
  },
  { 'echasnovski/mini.bracketed' },
  { 'echasnovski/mini.sessions' },
  { 'echasnovski/mini.move' },
}
