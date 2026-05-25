return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      diagnostics = {
        underline = false,
        virtual_text = false,
      },
      inlay_hints = { enabled = false },
      codelens = { enabled = true },
      setup = {
        gopls = function(_, opts)
          Snacks.util.lsp.on({ name = 'gopls' }, function(_, client)
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              if semantic ~= nil then
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end
          end)
        end,
      },
      servers = {
        gopls = {
          settings = {
            gopls = {
              buildFlags = { '-tags=integration' },
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                shadow = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = {
                '-.git',
                '-.vscode',
                '-.idea',
                '-.vscode-test',
                '-node_modules',
              },
              semanticTokens = true,
            },
          },
        },
        dexter = {
          cmd = { 'dexter', 'lsp' },
          root_markers = { '.dexter.db', '.git', 'mix.exs' },
          filetypes = { 'elixir', 'eelixir', 'heex' },
          init_options = {
            followDelegates = true,
          },
        },
      },
    },
    keys = {
      { '<C-k>', false },
    },
  },
  {
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function() require('conform').format { async = true, lsp_fallback = true } end,
        mode = '',
        desc = 'Format Document',
      },
    },
    opts = {
      formatters = {
        ['markdown-toc'] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find '<!%-%- toc %-%->' then return true end
            end
          end,
        },
        ['markdownlint-cli2'] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(
              function(d) return d.source == 'markdownlint' end,
              vim.diagnostic.get(ctx.buf)
            )
            return #diag > 0
          end,
        },
        sqlfluff = {
          args = { 'format', '--dialect=ansi', '-' },
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        go = { 'golines', 'goimports-reviser', 'gofumpt' },
        sh = { 'shfmt' },
        elixir = { 'mix' },
        ['markdown'] = { 'prettierd', 'markdownlint-cli2', 'markdown-toc' },
        ['markdown.mdx'] = { 'prettierd', 'markdownlint-cli2', 'markdown-toc' },
        sql = { 'sqlfluff', 'sql-formatter' },
      },
      format_on_save = false,
    },
  },
}
