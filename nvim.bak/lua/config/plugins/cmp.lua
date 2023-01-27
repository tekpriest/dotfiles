local cmp = require 'cmp'
local snip = require 'luasnip'
local kind = require 'lspkind'

local icons = {
	menu = {
		nvim_lsp = 'λ',
		vsnip = '⋗',
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

cmp.setup {
	snippet = {
		expand = function(args)
			snip.lsp_expand(args.body)
		end,
	},
	mapping = {
		['<Up>'] = cmp.mapping.select_prev_item(),
		['<Down>'] = cmp.mapping.select_next_item(),
		['C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {
			'i',
			'c',
		}),
		['<C-e>'] = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		},
		['<CR>'] = cmp.mapping.confirm { select = false },
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif snip.expandable() then
				snip.expand()
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
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'nvim_lsp_document_symbol' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'nvim_lua' },
	},
	formatting = {
		-- fields = { 'menu', 'abbr', 'kind' },
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
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = true,
		native_menu = false,
	},
	completion = {
		keyword_length = 1,
	},
	sorting = {
		comparators = {
			require 'clangd_extensions.cmp_scores',
		},
	},
}
