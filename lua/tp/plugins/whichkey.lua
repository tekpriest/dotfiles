return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    marks = false,
    registers = false,
  },
  config = function()
    local wk = require 'which-key'

    wk.register({
      -- files
      f = {
        name = 'file',
        f = { '<cmd>Telescope find_files<cr>', 'find files' },
        b = { '<cmd>Telescope buffers<cr>', 'list buffers' },
        w = { '<cmd>Telescope live_grep<cr>', 'live text search' },
        y = {
          function()
            require('telescope').extensions.neoclip.default()
          end,
          'fetch all pastes',
        },
      },
      -- lsp
      l = {
        name = 'lsp',
        r = { '<cmd>Telescope lsp_references<cr>', 'find references' },
        s = { '<cmd>Telescope lsp_workspace_symbols<cr>', 'find references' },
        f = { '<cmd>lua vim.lsp.buf.format()<cr>', 'format buffer' },
        x = { '<cmd>Telescope diagnostics<cr>', 'current diagnostics' },
        i = { '<cmd>Telescope lsp_implementation<cr>', 'go to implementation' },
        d = { '<cmd>Telescope lsp_definitions<cr>', 'go to definition' },
        D = {
          '<cmd>Telescope lsp_type_definitions<cr>',
          'go to type definition',
        },
      },
      -- file manager
      e = { '<cmd>Neotree toggle<cr>', 'toggle neotree' },
      o = { '<cmd>Neotree reveal<cr>', 'show file in neotree' },
      -- terraform
      t = {
        name = 'terraform',
        i = { '<cmd>Terraform init<cr>', 'initialize terraform' },
        p = { '<cmd>Terraform plan<cr>', 'plan terraform' },
        a = { '<cmd>Terraform apply<cr>', 'apply terraform plan' },
        d = { '<cmd>Terraform destroy<cr>', 'destroy terraform plan' },
      },
      -- session management
      q = {
        s = {
          function()
            require('persistence').load()
          end,
          'load directory session',
        },
        q = { '<cmd>q<cr>', 'quit editor' },
      },
      -- undotree
      u = {
        u = { '<cmd>UndotreeFocus<cr>', 'toggle undo tree' },
      },
    }, {
      prefix = '<leader>',
    })
  end,
}
