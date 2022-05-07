local ok, dap = pcall(require, "dap")
if not ok then
	return
end

local ok, dapui = pcall(require, "dapui")
if not ok then
	return
end

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- use table to apply multiple mapppings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	sidebar = {
		elements = {
			{
				id = "scopes",
				size = 0.25,
			},
			{
				id = "breakpoints",
				size = 0.25,
			},
		},
		size = 40,
		position = "right",
	},
	tray = {
		elements = { "repl" },
		position = "bottom",
	},
	floating = {
		max_height = nil,
		max_width = nil,
		border = "rounded",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
})

local icons = require("tp.configs.icons")

vim.fn.sign_define("DapBreakpoint", { text = icons.ui.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeers.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeers.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeers.before.event_exited["dapui_config"] = function()
	dapui.close()
end
