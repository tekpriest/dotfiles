return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        's1n7ax/nvim-window-picker',
        config = function()
          require('window-picker').setup {
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },

                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', 'quickfix' },
              },
            },
            other_win_hl_color = '#e35e4f',
          }
        end,
      },
    },
    event = 'VeryLazy',
    cmd = { 'NeoTreeToggle', 'NeoTreeFocus', 'Neotree' },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = true
    end,
    opts = {
      -- sources = {
      --   'filesystem',
      --   'git_status',
      -- },
      auto_clean_after_session_restore = true,
      filesystem = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = { 'node_modules', '.git', '.cache' },
        follow_current_file = {
          enable = true,
        },
        hijack_netrw_behavior = 'open_current',
      },
      window = {
        position = 'right',
        width = 30,
      },
      default_component_configs = {
        icon = {
          folder_empty = '󰜌',
          folder_empty_open = '󰜌',
        },
        git_status = {
          symbols = {
            renamed = '󰁕',
            unstaged = '󰄱',
          },
        },
      },
      document_symbols = {
        kinds = {
          File = { icon = '󰈙', hl = 'Tag' },
          Namespace = { icon = '󰌗', hl = 'Include' },
          Package = { icon = '󰏖', hl = 'Label' },
          Class = { icon = '󰌗', hl = 'Include' },
          Property = { icon = '󰆧', hl = '@property' },
          Enum = { icon = '󰒻', hl = '@number' },
          Function = { icon = '󰊕', hl = 'Function' },
          String = { icon = '󰀬', hl = 'String' },
          Number = { icon = '󰎠', hl = 'Number' },
          Array = { icon = '󰅪', hl = 'Type' },
          Object = { icon = '󰅩', hl = 'Type' },
          Key = { icon = '󰌋', hl = '' },
          Struct = { icon = '󰌗', hl = 'Type' },
          Operator = { icon = '󰆕', hl = 'Operator' },
          TypeParameter = { icon = '󰊄', hl = 'Type' },
          StaticMethod = { icon = '󰠄 ', hl = 'Function' },
        },
      },
      -- Add this section only if you've configured source selector.
      -- source_selector = {
      --   winbar = true,
      --   sources = {
      --     { source = 'filesystem', display_name = '  ' },
      --     { source = 'git_status', display_name = '  ' },
      --   },
      -- },
    },
    config = function(_, opts)
      require('neo-tree').setup(opts)

      local wk = require 'which-key'
      wk.register({
        -- file manager
        e = { '<cmd>Neotree toggle<cr>', 'toggle neotree' },
        o = { '<cmd>Neotree reveal<cr>', 'show file in neotree' },
      }, { prefix = '<leader>' })
    end,
  },
}
