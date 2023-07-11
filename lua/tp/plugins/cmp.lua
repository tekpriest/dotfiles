local Utils = require 'tp.utils'
local Icons = require 'tp.icons'
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'rafamadriz/friendly-snippets' },
    { 'L3MON4D3/LuaSnip' },
  },
  config = function()
    local cmp = require 'cmp'
    local snip = require 'luasnip'
    local replace = cmp.SelectBehavior.Replace

    cmp.setup {
      enabled = function()
        if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
          return false
        end
        return true
      end,

      performance = {
        debounce = 80,
        throttle = 80,
      },

      preselect = cmp.PreselectMode.Item,

      snippet = {
        expand = function(args)
          snip.lsp_expand(args.body)
        end,
      },

      completion = {
        completeopt = 'menu,menuone,noinsert,preview,noselect',
        keyword_length = 2,
      },

      matching = {
        dissallow_fuzzy_matching = false,
        dissallow_partial_matching = false,
        dissallow_prefix_unmatching = false,
      },

      -- window = {
      --   completion = cmp.config.window.bordered(),
      --   documentation = cmp.config.window.bordered(),
      -- },

      mapping = {
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Replace }
          elseif snip.expand_or_jumpable() then
            snip.expand_or_jump()
          elseif Utils.has_words_before() then
            cmp.complete()
          elseif Utils.check_backspace() then
            fallback()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            snip.select_prev_item { behavior = replace }
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

      formatting = {
        fields = { 'kind', 'abbr' },
        format = function(_, vim_item)
          vim_item.kind = Icons.cmp_kinds[vim_item.kind] or ''
          return vim_item
        end,
      },

      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer', keyword_length = 3 },
        { name = 'luasnip' },
      },

      experimental = { ghost_text = false, native_menu = false },
      confirm_opts = { behavior = cmp.ConfirmBehavior.Replace },
    }
    cmp.setup.cmdline('/', {
      completion = { autocomplete = false },
      sources = { { name = 'buffer' } },
    })
    cmp.setup.cmdline(':', {
      completion = { autocomplete = false },
      sources = cmp.config.sources {
        {
          name = 'path',
        },
        {
          name = 'cmdline',
        },
      },
    })
  end,
}
