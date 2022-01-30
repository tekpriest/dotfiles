local vim = vim
local formatter = require("formatter")
local prettierConfig = function()
	return {
		exe = "prettier",
		args = { "--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
		stdin = true,
	}
end

local formatterConfig = {
	lua = {
		function()
			return {
				exe = "stylua",
				args = { "-" },
				stdin = true,
			}
		end,
	},
	rust = {
		function()
			return {
				exe = "rustfmt",
				args = { "--emit=stdout" },
				stdin = true,
			}
		end,
	},
	swift = {
		function()
			return {
				exe = "swift-format",
				args = { vim.api.nvim_buf_get_name(0) },
				stdin = true,
			}
		end,
	},
	vue = {
		function()
			return {
				exe = "prettier",
				args = {
					"stdin-filepath",
					vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
					"--single-quote",
					"--parser",
					"vue",
				},
				stdin = "vue",
			}
		end,
	},
	sh = {
		function()
			return {
				exe = "shfmt",
				args = { "-i", 2 },
				stdin = true,
			}
		end,
	},
	prisma = {
		function()
			return {
				exe = "prisma-fmt",
				args = { "-" },
				stdin = true,
			}
		end,
	},
	dart = {
		function()
			return {
				exe = "dart format",
				args = { "-" },
				stdin = true,
			}
		end,
	},
	["*"] = {
		function()
			return {
				exe = "sed",
				args = { "-i", "'s/[ \t]*$//'" },
				stdin = false,
			}
		end,
	},
}

local commonFT = {
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	"svelte",
	"html",
	"markdown",
	"yaml",
	"json",
	"css",
	"scss",
	"typescript",
	"markdown.mdx",
}

for _, ft in ipairs(commonFT) do
	formatterConfig[ft] = { prettierConfig }
end

formatter.setup({
	logging = true,
	filetype = formatterConfig,
})
