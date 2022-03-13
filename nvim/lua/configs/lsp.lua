local lsp = TP.require("lspconfig")
local cmp_lsp = TP.require("cmp_nvim_lsp")
local status = TP.require("lsp-status")
-- register status progress
status.register_progress()
-- diagnostic signs
local signs = {
	Error = "",
	Warn = "",
	Hint = "",
	Info = "",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, {
		text = icon,
		texthl = hl,
		numhl = nil,
	})
end

-- diagnostic
vim.diagnostic.config({
	virtual_text = true,
	signs = { active = true },
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
-- lsp keymappings
local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>p", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

local on_attach = function(client, bufnr)
	status.on_attach(client)
	-- client.resolved_capabilities.document_formatting = false
	-- client.resolved_capabilities.document_range_formatting = false
	lsp_keymaps(bufnr)
	-- code highlight
	-- if client.resolved_capabilities.document_highlight then
	-- 	vim.api.nvim_command("autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()")
	-- 	vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
	-- 	vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()")
	-- end
	if client.resolved_capabilities.code_lens then
		vim.api.nvim_command("autocmd BufEnter,CursorHold,InsertLeave, <buffer> lua vim.lsp.codelens.refresh()")
	end
	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_command("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
end

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_lsp.update_capabilities(capabilities)
capabilities = vim.tbl_extend("keep", capabilities or {}, status.capabilities)
-- Lua

local sumneko_path = os.getenv("HOME") .. "/.local/bin/lua-language-server"
local sumneko_bin = sumneko_path .. "/bin/lua-language-server"
lsp.sumneko_lua.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		on_attach(client, bufnr)
	end,
	cmd = { sumneko_bin, "-E", sumneko_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			completion = {
				enable = true,
				keywordSnipped = "Replace",
				callSnippet = "Replace",
			},
			diagnostics = {
				globals = {
					"vim",
					"use",
					"describe",
					"packer_plugins",
				},
			},
			telemetry = { enable = false },
			maxPreload = 2000,
			preloadFileSize = 1000,
		},
	},
})
lsp.zls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- gopls
lsp.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.zls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
-- formatting
local null = TP.require("null-ls")
local b = null.builtins
null.setup({
	sources = {
		b.formatting.stylua,
		b.formatting.protolint,
		-- b.formatting.deno_fmt.with({
		-- 	extra_args = {
		-- 		"--options-single-quote",
		-- 	},
		-- }),
		b.formatting.prettier.with({
			filetypes = { "html", "json", "yaml", "markdown" },
		}),
		---diagnostics
		-- b.code_actions.eslint_d,
		-- b.diagnostics.eslint_d.with({
		-- 	diagnostics_format = "#{m} [#{c}]",
		-- 	condition = function(utils)
		-- 		print(utils.root_has_file({ ".eslintrc.js" }))
		-- 		return utils.root_has_file({ ".eslintrc", ".eslintrc.json" })
		-- 	end,
		-- }),
		b.diagnostics.protolint,
		-- hover
		b.hover.dictionary,
	},
	on_attach = on_attach,
	capabilities = capabilities,
})
