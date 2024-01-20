return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Mason',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    opts = {
      servers = {},
      setup = {},
      format = {
        timeout_ms = 3000,
      },
    },
    config = function(_, opts)
      require('plugins.lsp.setup').setup(_, opts)
      -- require('core.utils.notify').register_lsp()
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = 'ConformInfo',
    keys = {
      {
        -- Customize or remove this keymap to your liking
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
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
        lua = { 'stylua' },
        go = { 'gofumpt', 'goimports-reviser' },
        sh = { 'shfmt' },
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
        function()
          require('trouble').open 'document_diagnostics'
        end,
        desc = 'document diagnostics',
      },
      {
        '<leader>xw',
        function()
          require('trouble').open 'workspace_diagnostics'
        end,
        desc = 'workspace diagnostics',
      },
    },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'LspAttach',
    init = function()
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      require('ufo').setup {
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = ('  %d '):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              -- str width returned from truncate() may less than 2nd argument, need padding
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { suffix, 'MoreMsg' })
          return newVirtText
        end,
        close_fole_kinds = { 'imports', 'comment' },
        preview = {
          win_config = {
            border = { '', '─', '', '', '', '─', '', '' },
            winhighlight = 'Normal:Folded',
            winblend = 0,
          },
        },
      }
    end,
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
      local mr = require 'mason-registry'
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = 'LspAttach',
    opts = {
      linters_by_ft = {
        elixir = { 'credo' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        yaml = { 'yamllint' },
        zsh = { 'zsh' },
        proto = { 'buf_lint' },
        env = { 'dotenv_linter' },
        go = { 'golangcilint' },
        docker = { 'hadolint' },
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
