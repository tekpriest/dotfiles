local lspconfig = require 'lspconfig'
local cmp_lsp = require 'cmp_nvim_lsp'

local server_config = {}

require('mason').setup()
require('mason-lspconfig').setup {
	ensure_installed = {
		'sumneko_lua',
		'tsserver',
		'clangd',
		'cmake',
		'gopls',
		'jsonls',
		'yamlls',
		'dockerls',
		'sqlls',
	},
	automatic_installation = true,
}

-- diagnostic signs
local signs = {
	Error = '',
	Warn = '',
	Hint = '',
	Info = '',
}

for type, icon in pairs(signs) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, {
		text = icon,
		texthl = hl,
		numhl = nil,
	})
end

-- diagnostic
vim.diagnostic.config {
	virtual_text = true,
	signs = { active = true },
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = 'minimal',
		border = 'rounded',
		source = 'always',
		header = '',
		prefix = '',
	},
}

vim.lsp.handlers['textDocument/hover'] =
	vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] =
	vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
-- lsp keymappings
local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local map = vim.api.nvim_buf_set_keymap
	map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	map(bufnr, 'n', 'gla', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	map(bufnr, 'n', 'gj', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	map(bufnr, 'n', 'gk', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	map(bufnr, 'n', '<leader>p', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

server_config.on_attach = function(client, bufnr)
	--status.on_attach(client)
	lsp_keymaps(bufnr)
	if client.server_capabilities.documentFormattingProvider then
		vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
		vim.api.nvim_command 'autocmd BufWritePre <buffer> lua vim.lsp.buf.format()'
	end
	-- Server capabilities spec:
	-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
		vim.api.nvim_clear_autocmds { buffer = bufnr, group = 'lsp_document_highlight' }
		vim.api.nvim_create_autocmd('CursorHold', {
			callback = vim.lsp.buf.document_highlight,
			buffer = bufnr,
			group = 'lsp_document_highlight',
			desc = 'Document Highlight',
		})
		vim.api.nvim_create_autocmd('CursorMoved', {
			callback = vim.lsp.buf.clear_references,
			buffer = bufnr,
			group = 'lsp_document_highlight',
			desc = 'Clear All the References',
		})
	end
end

-- capabilities
server_config.capabilities = vim.lsp.protocol.make_client_capabilities()
server_config.capabilities = cmp_lsp.default_capabilities()
--capabilities = cmp_lsp.update_capabilities(capabilities)
--capabilities = vim.tbl_extend("keep", capabilities or {}, status.capabilities)

-- setup servers
require('config.plugins.lsp.servers.sumneko').setup(lspconfig, server_config)
require('config.plugins.lsp.servers.tsserver').setup(lspconfig, server_config)
require('config.plugins.lsp.servers.clangd').setup(lspconfig, server_config)

lspconfig.prismals.setup {
	on_attach = server_config.on_attach,
	capabilities = server_config.capabilities,
}

lspconfig.dockerls.setup {
	on_attach = server_config.on_attach,
	capabilities = server_config.capabilities,
}
lspconfig.jsonls.setup {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		server_config.on_attach(client, bufnr)
	end,
	capabilities = server_config.capabilities,
}
lspconfig.cmake.setup {
	on_attach = server_config.on_attach,
	capabilities = server_config.capabilities,
}

require('config.plugins.null_ls').setup_null(server_config)
