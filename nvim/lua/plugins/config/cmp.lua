local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

-- setup snippet
cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Spacce>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({
			select = false,
		}),
	},
	["<Tab>"] = function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
		else
			fallback()
		end
	end,
	["<S-Tab>"] = function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
		else
			fallback()
		end
	end,
	sources = {
		{ name = "nvim_lsp" },
		{ name = "emoji" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			maxwidth = 50,
			menu = {
				buffer = "",
				nvim_lsp = "",
				spell = "",
				look = "",
			},
		}),
	},
	experimental = {
		ghost_text = true,
		native_menu = true,
	},
})
