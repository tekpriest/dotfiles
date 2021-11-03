local lsp = require("lspconfig")

require("lspkind").init({
	with_text = true,
	preset = "default",
	symbol_map = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "ﰠ",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "塞",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "פּ",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},
})

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = capabilities,
	}
	server:setup(opts)
	vim.cmd([[do User LspAttachBuffers]])
end)

-- Enable LSPs
--[[
local servers = {'pyright', 'rust_analyzer', 'solargraph', 'ccls'}
for _, server in ipairs(servers) do
  lsp[server].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

lsp.ccls.setup {
  on_attach = on_attach;
  capabilities = capabilities;
  init_options = {
    cache = {
      directory = ".ccls-cache";
    };
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = {"-frounding-match"}
    }
  }
}
local sumneko_root_path = vim.fn.getenv("HOME") .. "/.local/bin/lua-language-server"
local sumneko_binary_path = sumneko_root_path .. "/bin/macOS/lua-language-server"
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp.sumneko_lua.setup({
	cmd = { sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
]]
