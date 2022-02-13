local mapBuf = require("utils.set-key").setBufKey
local nvim_cmp = require("cmp_nvim_lsp")
local lsp = require("lspconfig")

local lsp_status = require("lsp-status")
lsp_status.register_progress()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = nvim_cmp.update_capabilities(capabilities)
capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = { "documentation", "detail", "additionalTextEdits" },
-- }

local on_attach = function(client, bufnr)
	-- client.resolved_capabilities.document_formatting = false
	-- client.resolved_capabilities.document_range_formatting = false

	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	mapBuf(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
	mapBuf(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
	mapBuf(bufnr, "n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
	mapBuf(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover()<cr>")
	mapBuf(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	mapBuf(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	mapBuf(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>")
	mapBuf(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")

	if client.resolved_capabilities.document_formatting then
	  vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end

	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()")
		vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
		vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()")
	end
end
local sumneko_path = os.getenv("HOME") .. "/.local/bin/lua-language-server"
local sumneko_bin = sumneko_path .. "/bin/macOS/lua-language-server"

-- Lua
lsp.sumneko_lua.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { sumneko_bin, "-E", sumneko_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			completion = {
				enable = true,
				callSnippet = "Disable",
				showWord = "Disable",
			},
			diagnostics = {
				enable = true,
				globals = { "vim", "global", "use", "describe", "it", "assert", "before_each", "after_each" },
				-- disable = { "lowercase-global" },
			},
			telemetry = { enable = false },
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
				maxPreload = 2000,
				preloadFileSize = 1000,
				-- checkThirdParty = false,
			},
		},
	},
})

-- Elixir
local elixir_lsp_loc = vim.fn.expand("~/.local/bin/elixir-ls/release/language_server.sh")
lsp.elixirls.setup({
	cmd = { elixir_lsp_loc },
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		elixirLS = {
			dialyzerEnabled = false,
			fetchDeps = true,
		},
	},
})

local servers = {
	"gopls",
	"graphql",
	"html",
	"prismals",
	"yamlls",
	"vimls",
	"sourcekit",
	"svelte",
	"tailwindcss",
	"tsserver",
	"gopls",
	"gdscript",
}
for _, s in ipairs(servers) do
	lsp[s].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 100,
		},
		init_options = {
			lint = true,
		},
	})
end

lsp.eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		quiet = true,
	},
})

-- JSONLS
lsp.jsonls.setup({
	cmd = { "vscode-json-language-server", "--stdio" },
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "json", "jsonc" },
	settings = {
		json = {
			-- Schemas https://www.schemastore.org
			schemas = {
				{
					fileMatch = { "package.json" },
					url = "https://json.schemastore.org/package.json",
				},
				{
					fileMatch = { "manifest.json", "manifest.webmanifest" },
					url = "https://json.schemastore.org/web-manifest-combined.json",
				},
				{
					fileMatch = { "tsconfig*.json" },
					url = "https://json.schemastore.org/tsconfig.json",
				},
				{
					fileMatch = {
						".prettierrc",
						".prettierrc.json",
						"prettier.config.json",
					},
					url = "https://json.schemastore.org/prettierrc.json",
				},
				{
					fileMatch = { ".eslintrc", ".eslintrc.json" },
					url = "https://json.schemastore.org/eslintrc.json",
				},
				{
					fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
					url = "https://json.schemastore.org/babelrc.json",
				},
				{
					fileMatch = { "lerna.json" },
					url = "https://json.schemastore.org/lerna.json",
				},
				{
					fileMatch = { "now.json", "vercel.json" },
					url = "https://json.schemastore.org/now.json",
				},
				{
					fileMatch = {
						".stylelintrc",
						".stylelintrc.json",
						"stylelint.config.json",
					},
					url = "http://json.schemastore.org/stylelintrc.json",
				},
			},
		},
	},
})

-- CSS
lsp.ccls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		scss = {
			lint = {
				idSelector = "warning",
				zeroUnits = "warning",
				duplicateProperties = "warning",
			},
			completion = {
				completePropertyWithSemicolon = true,
				triggerPropertyValueCompletion = true,
			},
		},
	},
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_on_insert = true,
})

local signs = {
	Error = "ﰸ",
	Warn = "",
	Hint = "",
	Info = "",
}
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, {
		text = icon,
		texthl = hl,
		numhl = nil,
	})
end

vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float({focus=false})]])

return on_attach
