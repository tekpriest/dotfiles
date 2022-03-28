local cmp = require('cmp')
local snip = require('luasnip')
local kind = require("lspkind")

cmp.setup{
  snippet = {
    expand = function(args)
      snip.lsp_expand(args.body)
    end,
  },
  mapping = {
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
		["C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {
			"i",
			"c",
		}),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		--   if cmp.visible() then
		--     cmp.select_next_item()
		--   elseif snip.expandable() then
		--     snip.expand()
		--   elseif snip.expand_or_jumpable() then
		--     snip.expand_or_jump()
		--   elseif check_backspace() then
		--     fallback()
		--   else
		--     fallback()
		--   end
		-- end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif snip.jumpable(-1) then
				snip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
  },
  sources = {
    {name='nvim_lsp'},
    {name='luasnip'},
    {name='buffer'},
    {name='path'},
    {name='nvim_lsp_document_symbol'},
    {name='nvim_signature_lsp'}
  },
  formatting = {
    format = kind.cmp_format{
      mode = 'symbol',
      maxwidth=40,
    }
  },
  duplicates = {
    nvim_lsp = 1,
    luasnip = 1,
    buffer = 1,
    path = 1
  },
  experimental = {
    ghost_text = true,
    native_menu = false
  },
  completion = {
    keyword_length = 1
  }
}
