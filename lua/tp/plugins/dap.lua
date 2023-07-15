return {
  { 'mfussenegger/nvim-dap' },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    event = 'VeryLazy',
    opts = {
      handlers = {},
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      local wk = require 'which-key'
      wk.register({
        d = {
          name = 'debugger',
          b = { '<cmd>DapToggleBreakpoint<cr>', 'toggle break point' },
          r = { '<cmd>DapContinue<cr>', 'start or continue' },
        },
      }, {
        prefix = '<leader>',
      })
    end,
  },
}
