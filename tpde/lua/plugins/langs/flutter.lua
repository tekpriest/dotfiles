return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'dart' })
    end,
  },
  {
    'akinsho/flutter-tools.nvim',
    ft = { 'dart' },
    opts = function()
      return {
        debugger = {
          enabled = false,
          run_via_dap = false,
          exception_breakpoints = {},
        },
        outline = { auto_open = false },
        widget_guides = { enabled = false, debug = false },
        dev_log = { enabled = true, open_cmd = 'tabedit' },
        lsp = {
          color = {
            enabled = true,
            background = true,
            virtual_text = false,
          },
          settings = {
            showTodos = true,
            renameFilesWithClasses = 'always',
            updateImportsOnRename = true,
            completeFunctionCalls = true,
            lineLength = 100,
          },
        },
      }
    end,
    dependencies = {
      { 'RobertBrunhage/flutter-riverpod-snippets' },
    },
  },
}
