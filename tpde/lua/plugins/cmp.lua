return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'windwp/nvim-ts-autotag',
      'L3MON4D3/LuaSnip',
      'petertriho/cmp-git',
      'amarakon/nvim-cmp-buffer-lines',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'SergioRibera/cmp-dotenv',
      {
        'L3MON4D3/LuaSnip',
        opts = {
          history = true,
          update_events = { 'TextChanged', 'TextChangedI' },
        },
        config = function(_, opts)
          require('luasnip').setup(opts)

          -- load snippets
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local Utils = require 'core.utils'

      cmp.setup {
        -- completion = { completeopt = 'menu,menuone,noinsert,preview' },
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        formatting = {
          expandable_indicator = true,
          fields = { 'abbr', 'kind' },
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
          {
            name = 'nvim_lsp',
            entry_filter = function(entry, _)
              return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
            end,
          },
          { name = 'nvim_lua' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'dotenv' },
        }),

        -- cmp.setup.cmdline({ '/', '?' }, {
        --   mapping = cmp.mapping.preset.cmdline(),
        --   sources = {
        --     { name = 'buffer', option = { keyword_pattern = [[\k\+]] } },
        --   },
        -- }),

        -- cmp.setup.filetype({ 'c', 'cpp' }, {
        --   sources = {
        --     { name = 'buffer-lines' },
        --   },
        -- }),
      }
    end,
  },
}
