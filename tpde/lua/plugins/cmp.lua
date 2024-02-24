return {
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
    config = function(_, opts)
      require('luasnip').setup(opts)

      -- load snippets
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'windwp/nvim-ts-autotag',
      'L3MON4D3/LuaSnip',
      'petertriho/cmp-git',
      'amarakon/nvim-cmp-buffer-lines',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'davidsierradz/cmp-conventionalcommits',
    },
    init = function()
      vim.api.nvim_set_hl(
        0,
        'CmpItemAbbrDeprecated',
        { bg = 'NONE', strikethrough = true, fg = '#808080' }
      )
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
      vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
      vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
      vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
      vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
      vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
      vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
      vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
      vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
    end,
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local Utils = require 'core.utils'

      cmp.setup {
        completion = { completeopt = 'menu,menuone,noinsert,preview' },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          expandable_indicator = true,
        },
        experimental = {
          hl_group = 'LspCodeLens',
          ghost_text = {},
        },
        mapping = {
          ['<CR>'] = cmp.mapping.confirm { select = false, beahvior = cmp.ConfirmBehavior.Insert },
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif Utils.has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.expand_or_jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        -- window = {
        --   completion = cmp.config.window.bordered(),
        --   documentation = cmp.config.window.bordered(),
        -- },
        sources = cmp.config.sources({
          { name = 'luasnip' },
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
          { name = 'cmdline' },
        }),

        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'git' },
            { name = 'conventionalcommits' },
          }, {
            { name = 'buffer' },
          }),
        }),

        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer',      option = { keyword_pattern = [[\k\+]] } },
            { name = 'buffer-lines' },
          },
        }),

        cmp.setup.filetype({ 'c', 'cpp', 'elixir' }, {
          sources = {
            { name = 'buffer-lines' },
          },
        }),
      }
    end,
  },
}
