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
      ['<space>'] = { '<cmd>Telescope find_files<cr>', 'find files' },
      -- files
      f = {
        name = 'file',
        f = { '<cmd>Telescope find_files<cr>', 'find files' },
        b = { '<cmd>Telescope buffers<cr>', 'list buffers' },
        w = { '<cmd>Telescope live_grep<cr>', 'live text search' },
        g = { '<cmd>Telescope live_grep<cr>', 'live text search' },
      },
      -- code
      c = {
        name = 'code',
        a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'code action' },
        r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'rename' },
        s = { '<cmd>Telescope lsp_workspace_symbols<cr>', 'workspace symbols' },
        f = { '<cmd>lua vim.lsp.buf.format()<cr>', 'format buffer' },
        d = { '<cmd>Telescope diagnostics<cr>', 'current diagnostics' },
      },
      -- file manager
      e = { '<cmd>Neotree toggle<cr>', 'toggle neotree' },
      o = { '<cmd>Neotree reveal<cr>', 'show file in neotree' },
      -- refactoring
      r = {
        r = {
          "<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>",
          'refactor code',
        },
        v = {
          "<cmd>lua require('refactoring').debug.print_var({ normal = true })<cr>",
          'print variable',
        },
        c = {
          "<cmd>lua require('refactoring').debug.cleanup({})<cr>",
          'cleanup',
        },
      },
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
