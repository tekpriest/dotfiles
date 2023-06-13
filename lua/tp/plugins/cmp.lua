local Utils = require 'tp.utils'
local Icons = require 'tp.icons'
return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'rafamadriz/friendly-snippets' },
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
    },
    opts = {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      formatting = {
        fields = { 'kind', 'abbr' },
        format = function(_, vim_item)
          vim_item.kind = Icons.cmp_kinds[vim_item.kind] or ''
          return vim_item
        end,
      },
      preselect = 'item',
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      mapping = {
        ['<CR>'] = require('cmp').mapping.confirm {
          select = true,
          behavior = require('cmp').ConfirmBehavior.Replace,
        },
        ['<C-Space>'] = require('cmp').mapping.complete(),
        ['<Tab>'] = vim.schedule_wrap(function(fallback)
          local cmp = require 'cmp'
          local snip = require 'luasnip'

          if cmp.visible() then
            cmp.select_next_item {
              behavior = cmp.SelectBehavior.Select,
            }
          elseif snip.expand_or_jumpable() then
            snip.expand_or_jump()
          elseif Utils.has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end),
        ['<S-Tab>'] = vim.schedule_wrap(function(fallback)
          local cmp = require 'cmp'
          local snip = require 'luasnip'

          if cmp.visible() then
            cmp.select_prev_item()
          elseif snip.jumpable(-1) then
            snip.jump(-1)
          else
            fallback()
          end
        end),
        ['<C-d>'] = require('cmp').mapping.scroll_docs(-4),
        ['<C-f>'] = require('cmp').mapping.scroll_docs(4),
        ['<C-e>'] = require('cmp').mapping.close(),
      },
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
      },
    },
    config = function(_, opts)
      local cmp = require 'cmp'

      cmp.setup(opts)
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())

      vim.cmd [[highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch]]
      vim.cmd [[highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]]
      vim.cmd [[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
      vim.cmd [[highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch]]
      vim.cmd [[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]]
      vim.cmd [[highlight! link CmpItemKindInterface CmpItemKindVariable]]
      vim.cmd [[highlight! link CmpItemKindText CmpItemKindVariable]]
      vim.cmd [[highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0]]
      vim.cmd [[highlight! link CmpItemKindMethod CmpItemKindFunction]]
      vim.cmd [[highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]]
      vim.cmd [[highlight! link CmpItemKindProperty CmpItemKindKeyword]]
      vim.cmd [[highlight! link CmpItemKindUnit CmpItemKindKeyword]]
    end,
  },
  -- {
  --   'hrsh7th/nvim-cmp',
  --   dependencies = {
  --     { 'zbirenbaum/copilot-cmp' },
  --   },
  --   opts = function(_, opts)
  --     local cmp = require 'cmp'
  --     opts.sources = cmp.config.sources(
  --       vim.list_extend(opts.sources, { { name = 'copilot' } })
  --     )
  --   end,
  -- },
}
