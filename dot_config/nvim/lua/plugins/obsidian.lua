return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = 'notes',
        path = '~/Code/notes',
      },
      {
        name = 'single',
        path = function()
          return assert(vim.fn.getcwd())
        end,
        overrides = {
          notes_subdir = vim.NIL,
          new_notes_location = 'current_dir',
          templates = {
            folder = vim.NIL,
          },
          disable_frontmatter = true,
        },
      },
    },
  },
  keys = {
    { '<localleader>od', '<cmd>Obsidian dailies<cr>', desc = 'Open dailies' },
    { '<localleader>ot', '<cmd>Obsidian today<cr>', desc = 'Open daily note' },
    { '<localleader>ott', '<cmd>Obsidian tomorrow<cr>', desc = 'Open tomorrow note' },
    { '<localleader>os', '<cmd>Obsidian quick_switch<cr>', desc = 'Switch notes' },
    { '<localleader>otg', '<cmd>Obsidian tags<cr>', desc = 'Tags' },
    { '<localleader>ow', '<cmd>Obsidian workspace<cr>', desc = 'Switch workspaces' },
  },
}
