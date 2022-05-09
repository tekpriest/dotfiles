local T = {}
local api = vim.api
local lsp = vim.lsp
local lspc = {}

local function on_init(client)
	lsp.util.text_document_completion_list_to_complete_items =
		require("lsp_compl").text_document_completion_list_to_complete_items
	if client.config.settings then
		client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
	end
end

local function on_exit(client, bufnr) end

local function mk_config()
	local capabilities = lsp.protocol.make_client_capabilities()
	capabilities.workspace.configuration = true
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	return {
		flags = {
			debounce_text_changes = 80,
			allow_incremental_sync = true,
		},
		handlers = {},
		capabilities = capabilities,
		on_init = on_init,
		on_exit = on_exit,
		init_options = {},
		settings = {},
	}
end

function T.start_lua_ls()
	local config = mk_config()
	local library = {}
	local path = vim.split(package.path, ";")
	table.insert(path, "lua/?.lua")
	table.insert(path, "lua/?/init.lua")

	local function add(lib)
		for _, p in pairs(vim.fn.expand(lib, false, true)) do
			p = vim.loop.fs_realpath(p)
			library[p] = true
		end
	end

	add("$VIMRUNTIME")
	add("~/.config/nvim")
	config.settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "it", "describe" },
			},
			runtime = {
				version = "LuaJIT",
				path = path,
			},
			workspace = {
				library = library,
			},
			telemetry = {
				enable = false,
			},
		},
	}
	local server_dir = vim.fn.expand("~/.local/bin/lls")
	config["name"] = "luals"
	config["cmd"] = { server_dir .. "bin/lua-language-server", server_dir .. "main.lua" }
	lspc.start(config, { ".git" })
end

function T.setup()
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = "single" }
	)
end

function remove_unused_imports()
	vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
	vim.cmd("packadd cfilter")
	vim.cmd("Cfilter /main/")
	vim.cmd("Cfilter /The import/")
	vim.cmd("cdo normal dd")
	vim.cmd("cclose")
	vim.cmd("wa")
end

local function mk_tag_item(name, range, uri)
	local start = range.start
	return {
		name = name,
		filename = vim.uri_to_fname(uri),
		cmd = string.format("call cursor(%d, %d)", start.line + 1, start.character + 1),
	}
end

function M.symbol_tagfunc(pattern, flags)
	if not (flags == "c" or flags == "" or flags == "i") then
		return vim.NIL
	end
	local clients = vim.lsp.get_active_clients()
	local num_clients = vim.tbl_count(clients)
	local results = {}
	for _, client in pairs(clients) do
		client.request("workspace/symbol", { query = pattern }, function(_, method_or_result, result_or_ctx)
			local result = type(method_or_result) == "string" and result_or_ctx or method_or_result
			for _, symbol in pairs(result or {}) do
				local loc = symbol.location
				local item = mk_tag_item(symbol.name, loc.range, loc.uri)
				item.kind = (lsp.protocol.SymbolKind[symbol.kind] or "Unknown")[1]
				table.insert(results, item)
			end
			num_clients = num_clients - 1
		end)
	end
	vim.wait(1500, function()
		return num_clients == 0
	end)
	return results
end

function T.gitlens()
	local ft = vim.fn.expand("%:h:t") -- get the current file extension
	if ft == "" then -- if current file is scratch buffer or unknown file type
		return
	end
	if ft == "bin" then -- if curent buffer is nvim's terminal window
		return
	end
	api.nvim_buf_clear_namespace(0, 2, 0, -1) -- clear out virtul text from namepsace 2
	local currFile = vim.fn.expand("%")
	local line = api.nvim_win_get_cursor(0)
	local blame = vim.fn.system(string.format("git blame -c -L %d,%d %s", line[1], line[1], currFile))
	local hash = vim.split(blame, "%s")[1]
	local cmd = string.format("git show %s ", hash) .. "--format='%an | %ar | %s'"
	if hash == "00000000" then
		text = "Not Committed Yet"
	else
		text = vim.fn.system(cmd)
		text = vim.split(text, "\n")[1]
		if text:find("fata") then -- if the call to git show fails
			text = "Not Committed Yet"
		end
	end
	api.nvim_buf_set_virtual_text(0, 2, line[1] - 1, { { text, "GitLens" } }, {}) -- set virtual text for namespace 2 with the content from git and assign it to the higlight group 'GitLens'
end

function T.clearGitLens() -- clear out git blame
	api.nvim_buf_clear_namespace(0, 2, 0, -1)
end

T.mk_config = mk_config

return T
