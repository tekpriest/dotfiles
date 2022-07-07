local plugins = {
	"nvimtree",
	"autopairs",
	"neoscroll",
	"telescope",
	"indentline",
	"treesitter",
	"cmp",
	"lsp",
	"bufferline",
	"spectre",
	"lualine",
}

for k, v in ipairs(plugins) do
	local plugin = "tp.configs.plugins." .. v
	require(plugin)
end
