return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  cmd = { 'NeoTreeToggle', 'NeoTreeFocus', 'Neotree' },
  init = function()
    vim.g.neo_tree_remove_legacy_commands = true
  end,
  opts = {
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        -- macOs: open file in default application in the background.
        vim.fn.jobstart({ 'xdg-open', '-g', path }, { detach = true })
        -- Linux: open file in default application
        -- vim.fn.jobstart({ 'xdg-open', path }, { detach = true })
      end,
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function(_)
          -- auto close
          -- vimc.cmd("Neotree close")
          -- OR
          require('neo-tree.command').execute { action = 'close' }
        end,
      },
    },
    auto_clean_after_session_restore = true,
    filesystem = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = { 'node_modules', '.git', '.cache', '_build' },
      follow_current_file = {
        enable = true,
      },
      hijack_netrw_behavior = 'open_current',
      mappings = {
        ['o'] = 'system_open',
      },
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
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', 'toggle explorer' },
    { '<leader>o', '<cmd>Neotree reveal<cr>', 'focus file' },
  },
}
