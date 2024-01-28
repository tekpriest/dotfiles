return {
  {
    'nvim-telescope/telescope.nvim',
    keys = {
      -- { '<leader>ss', false },
      { '<leader>gc', false },
      { '<leader>fw', '<cmd>Telescope live_grep<cr>', desc = 'live text search' },
    },
    dependencies = {
      {

        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').load_extension 'fzf'
        end,
      },
      {
        'ThePrimeagen/git-worktree.nvim',
        config = function()
          require('telescope').load_extension 'git_worktree'
        end,
      },
      {
        config = function()
          require('telescope').load_extension 'harpoon'
        end,
        'ThePrimeagen/harpoon',
      },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = {
      window = {
        position = 'right',
        width = 25,
      },
      event_handlers = {
        {
          event = 'file_opened',
          handler = function(_)
            require('neo-tree.command').execute { action = 'close' }
          end,
        },
      },
      filesystem = {
        follow_current_file = { enable = false },
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
    },
    keys = {
      { '<leader>o', '<cmd>Neotree reveal<cr>', desc = 'focus file', remap = true },
    },
  },
  {
    'nvim-pack/nvim-spectre',
    keys = {
      { '<leader>sr', false },
      {
        '<leaderss',
        function()
          require('spectre').open()
        end,
        desc = 'open spectre',
      },
    },
  },
}
