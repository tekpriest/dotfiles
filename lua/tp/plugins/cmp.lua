return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'rafamadriz/friendly-snippets' },
    {
      'L3MON4D3/LuaSnip',
      config = function()
        local snip = require 'luasnip'
        local types = require 'luasnip.util.types'

        require('luasnip/loaders/from_vscode').lazy_load()

        snip.config.set_config {
          history = true,
          updateevents = 'TextChanged,TextChangedI',
          anable_autosnippets = true,
          ext_opts = {
            [types.choiceNode] = {
              active = {
                virt_text = { { '●', 'DiagnosticHint' } },
              },
            },
            [types.insertNode] = {
              active = {
                virt_text = { { '●', 'DiagnosticInfo' } },
              },
            },
          },
        }
      end,
    },
    {
      'roobert/tailwindcss-colorizer-cmp.nvim',
      config = true,
      ft = { 'html', 'javascriptreact', 'typescriptreact', 'css' },
    },
  },
  config = function()
    local cmp = require 'cmp'
    local snip = require 'luasnip'

    cmp.setup {
      snippet = {
        expand = function(args)
          snip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<CR>'] = cmp.mapping.confirm { select = true, beahvior = cmp.ConfirmBehavior.Replace },
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif snip.expand_or_jumpable() then
            snip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif snip.jumpable(-1) then
            snip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-2), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(2), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
      },

      -- formatting = {
      --   expandable_indicator = true,
      --   fields = { 'kind', 'abbr' },
      --   format = function(entry, vim_item)
      --     vim_item.kind = Icons.cmp_kinds[vim_item.kind] or ''
      --     return require('tailwindcss-colorizer-cmp').formatter(entry, vim_item)
      --   end,
      -- },

      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer', keyword_length = 2 },
        { name = 'luasnip' },
      },

      -- experimental = { ghost_text = false },
      -- confirm_opts = { behavior = cmp.ConfirmBehavior.Replace },
    }
  end,
}
