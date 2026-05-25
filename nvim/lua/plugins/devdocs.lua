return {
  'maskudo/devdocs.nvim',
  lazy = false,
  dependencies = {
    'folke/snacks.nvim',
  },
  cmd = { 'DevDocs' },
  keys = {
    { '<leader>ho', '<cmd>DevDocs get<cr>', mode = 'n', desc = 'Get' },
    { '<leader>hi', '<cmd>DevDocs install<cr>', mode = 'n', desc = 'Install' },
    {
      '<leader>hv',
      function()
        local devdocs = require 'devdocs'
        local installed = devdocs.GetInstalledDocs()

        vim.ui.select(installed, {}, function(selected)
          if not selected then return end
          local doc = devdocs.GetDocDir(selected)
          Snacks.picker.files { cwd = doc }
        end)
      end,
      mode = 'n',
      desc = 'Select',
    },
  },
  opts = {
    ensure_installed = {
      'go',
      'html',
      'http',
      'lua~5.1',
    },
  },
  config = function(_, opts)
    -- Patch to fix E5560: Vimscript function must not be called in a fast event context
    -- This wraps the callback of InitializeMetadata in vim.schedule
    local docs = require 'devdocs.docs'
    local original_init = docs.InitializeMetadata
    docs.InitializeMetadata = function(args, callback)
      original_init(args, function()
        vim.schedule(function()
          if callback then callback() end
        end)
      end)
    end

    require('devdocs').setup(opts)
  end,
}
