return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- Creates a beautiful debugger UI
      {
        'rcarriga/nvim-dap-ui',
        opts = {
          icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
          controls = {
            icons = {
              pause = '⏸',
              play = '▶',
              step_into = '⏎',
              step_over = '⏭',
              step_out = '⏮',
              step_back = 'b',
              run_last = '▶▶',
              terminate = '⏹',
              disconnect = '⏏',
            },
          },
        },
        keys = {
          {
            '<leader>db',
            function()
              require('dapui').toggle()
            end,
            desc = 'Toggle DAP UI',
          },
        },
      },

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      {
        'jay-babu/mason-nvim-dap.nvim',
        opts = {
          automatic_setup = true,
          hendlers = {},
          ensure_installed = { 'delve' },
        },
      },

      -- Add your own debuggers here
      { 'leoluz/nvim-dap-go', config = true },
    },
    init = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
}
