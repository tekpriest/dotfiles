local kind = require 'lspkind'
vim.o.completeopt = 'menu,menuone,noselect'

local icons = {
  menu = {
    nvim_lsp = 'λ',
    vsnip = '⋗',
    luasnip = '⋗',
    ultisnips = '⋗',
    buffer = 'b',
    path = 'p',
  },
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = 'ﰠ',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = 'פּ',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

local cmp = require 'cmp'
local snip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snip.expandable() then
        snip.expand()
      elseif snip.expand_or_jumpable() then
        snip.expand_or_jump()
      elseif snip.jumpable(1) then
        snip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snip.jumpable(-1) then
        snip.jumpable(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<Down>'] = cmp.mapping(
      cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
      { 'i' }
    ),
    ['<Up>'] = cmp.mapping(
      cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
      { 'i' }
    ),
    ['<C-Space>'] = cmp.mapping(
      cmp.mapping.complete { behavior = cmp.SelectBehavior.Select },
      { 'i', 'c' }
    ),
    ['<C-]>'] = cmp.mapping(cmp.mapping.abort(), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping(cmp.mapping.close(), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping {
      i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
      -- c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
      c = function(fallback)
        if cmp.visible() and cmp.get_selected_entry() then
          cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
        else
          fallback()
        end
      end,
    },
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp_document_symbol' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, item)
      item.menu = icons.menu[entry.source.name]
      item.kind = kind.symbolic(item.kind, { mode = 'symbol' })
      return item
    end,
  },
  duplicates = {
    luasnip = 1,
    buffer = 1,
    path = 1,
  },
  window = {
    documentation = cmp.config.window.bordered(),
    completion = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = true,
  },
  completion = {
    Keyword_length = 1,
  },
  -- sorting = {
  --   comparators = {},
  -- },
}
-- cmp.setup.cmdline({ '/', '?' }, {
--   completion = { autocomplete = false },
--   sources = {
--     { name = 'nvim_lsp_document_symbol' },
--     { name = 'buffer' }, --, option = { keyword_pattern = [=[[^[:blank:]].*]=] } },
--   },
-- })
--
-- -- Use cmdline & path source for ':'.
-- cmp.setup.cmdline({ ':', '@', '=' }, {
--   completion = { autocomplete = false },
--   sources = cmp.config.sources({
--     { name = 'path' },
--   }, {
--     { name = 'cmdline' },
--   }),
-- })
--
-- cmp.setup.filetype({ 'markdown', 'pandoc', 'text', 'tex' }, {
--   sources = {
--     { name = 'buffer' },
--     { name = 'latex_symbols' },
--     { name = 'luasnip' },
--     { name = 'nvim_lsp' },
--     { name = 'nvim_lsp_signature_help' },
--     { name = 'path' },
--   },
-- })
