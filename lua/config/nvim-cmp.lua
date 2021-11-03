-- luasnip setup
local luasnip = require("luasnip")
local cmp = require("cmp")
require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-y>"] = cmp.config.disable,
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<TAB>"] = cmp.mapping.confirm({
			select = true,
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "luasnip" },
	},
})

-- Use buffer source for "/"
cmp.setup.cmdline("/", {
	sources = { { name = "buffer" } },
})

-- Use cmdline & path source for ":"
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}),
})
