local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api
        .nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
        :match '^%s*$'
      == nil
end

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'rafamadriz/friendly-snippets' },
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      local lsp = require('lsp-zero').preset {
        -- float_border = 'none',
      }

      lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set('n', 'gd', function()
          vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set('n', 'K', function()
          vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set('n', '[d', function()
          vim.diagnostic.goto_prev()
        end, opts)
        vim.keymap.set('n', ']d', function()
          vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set('n', 'gr', function()
          vim.lsp.buf.references()
        end, opts)
        vim.keymap.set('n', '<leader>rn', function()
          vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set('n', '<leader>ca', function()
          vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set('n', 'gs', function()
          vim.lsp.buf.signature_help()
        end, opts)
        vim.keymap.set('n', 'gl', function()
          vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set('n', 'gi', function()
          vim.lsp.buf.implementation()
        end, opts)
      end)

      lsp.ensure_installed {
        'tsserver',
        'prismals',
        'jsonls',
        'gopls',
        'lua_ls',
        'yamlls',
      }

      lsp.skip_server_setup { 'tsserver' }

      lsp.setup()

      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

      require('typescript').setup {}

      local cmp = require 'cmp'
      local cmp_action = require('lsp-zero').cmp_action()

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = { 'menu', 'abbr', 'kind' },
        },
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = {
          ['<CR>'] = cmp.mapping.confirm {
            select = false,
            behavior = cmp.ConfirmBehavior.Replace,
          },
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
              fallback()
            end
          end),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.close(),
        },
        sources = {
          { name = 'path' },
          { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'buffer', keyword_length = 3 },
          { name = 'luasnip', keyword_length = 2 },
        },
      }
    end,
  },
  { 'wakatime/vim-wakatime', event = 'VeryLazy' },
  { 'ellisonleao/glow.nvim', cmd = 'Glow', ft = { 'markdown' } },
  { 'b0o/SchemaStore.nvim', ft = { 'json', 'yaml' } },
  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = 'Copilot',
  --   event = 'InsertEnter',
  --   config = function()
  --     require('copilot').setup {
  --       suggestion = { enabled = false },
  --       panel = { enabled = false },
  --     }
  --   end,
  -- },
  -- {
  --   'zbirenbaum/copilot-cmp',
  --   config = function()
  --     require('copilot_cmp').setup()
  --   end,
  -- },
  {
    'windwp/nvim-autopairs',
    opts = {
      fast_wrap = {},
      disable_filetype = { 'TelescopePrompt', 'vim' },
    },
    config = function(_, opts)
      require('nvim-autopairs').setup(opts)

      -- setup cmp for autopairs
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      local null_ls = require 'null-ls'
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

      require('mason').setup()
      require('mason-null-ls').setup {
        ensure_installed = {
          'prettierd',
          'prismaFmt',
          'gofumpt',
          'stylua',
          'golines',
          'goimports-reviser',
          'tfsec',
        },
        automatic_installation = true,
        automatic_setup = true,
        handlers = {
          stylua = function()
            null_ls.register(null_ls.builtins.formatting.stylua)
          end,
          prettierd = function()
            null_ls.register(null_ls.builtins.formatting.prettierd)
          end,
          prismaFmt = function()
            null_ls.register(null_ls.builtins.formatting.prismaFmt)
          end,
        },
      }
      require('null-ls').setup {
        -- sources = { null_ls.builtins.formatting.prismaFmt },
        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { bufnr = bufnr }
              end,
            })
          end
        end,
      }
    end,
  },
}
