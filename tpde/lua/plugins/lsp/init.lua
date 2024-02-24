return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Mason',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    ---@class PluginLspOpts
    opts = {
      servers = {},
      setup = {},
      format = {
        timeout_ms = 3000,
      },
      diagnostics = {
        severity_sort = true,
        underline = false,
        update_in_insert = false,
        virtual_text = false,
        float = {
          focusable = false,
        },
        signs = true,
      },
      inlay_hints = { enabled = true },
    },
    config = function(_, opts) require('plugins.lsp.setup').setup(_, opts) end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = 'ConformInfo',
    keys = {
      {
        -- Customize or remove this keymap to your liking
        '<leader>cf',
        function() require('conform').format { async = true, lsp_fallback = true } end,
        mode = { 'n' },
        desc = 'Format buffer with conform',
      },
    },
    opts = {
      formatters_by_ft = {
        typescript = { 'prettierd' },
        javascript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        html = { 'prettierd' },
        elixir = { 'mix' },
        dart = { 'dart_format' },
        yaml = { 'prettierd' },
        json = { 'prettierd' },
        -- go = { 'gofumpt', 'goimports-reviser' },
        -- sh = { 'shfmt' },
      },
      format_on_save = false,
    },
  },
  {
    'folke/trouble.nvim',
    opts = {
      icons = false,
      action_keys = {
        open_split = 'S',
        open_vsplit = 's',
        switch_severity = { '<c-s>' },
      },
      fold_open = 'v',
      fold_closed = '>',
      indent_lines = false,
      signs = {
        error = 'E',
        warning = 'W',
        hint = 'H',
        information = 'I',
      },
      use_diagnostic_signs = false,
      auto_close = true,
    },
    keys = {
      {
        '<leader>xd',
        function() require('trouble').open('document_diagnostics') end,
        desc = 'document diagnostics',
      },
      {
        '<leader>xw',
        function() require('trouble').open('workspace_diagnostics') end,
        desc = 'workspace diagnostics',
      },
    },
  },
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'Mason',
    opts = {
      ensure_installed = {
        'shfmt',
        'lua-language-server',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
