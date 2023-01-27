local dap = require 'dap'
local dapui = require 'dapui'
local keymaps = require 'core.keymaps'

dap.adapters.delve = {
	type = 'server',
	port = '${port}',
	executable = {
		command = 'dlv',
		args = { 'dap', '-l', '127.0.0.1:${port}' },
	},
}

dap.configurations.go = {
	{
		type = 'delve',
		name = 'Debug',
		request = 'launch',
		program = '${file}',
	},
	{
		type = 'delve',
		name = 'Debug test', -- configuration for debugging test files
		request = 'launch',
		mode = 'test',
		program = '${file}',
	},
	-- works with go.mod packages and sub packages
	{
		type = 'delve',
		name = 'Debug test (go.mod)',
		request = 'launch',
		mode = 'test',
		program = './${relativeFileDirname}',
	},
}

-- keymaps
keymaps.map('n', '<F5>', [[:lua require'dap'.continue()<CR>]], keymaps.opts)
keymaps.map('n', '<C-b>', [[:lua require'dap'.toggle_breakpoint()<CR>]], keymaps.opts)
-- Press CTRL + c to toggle Breakpoint with Condition
keymaps.map(
	'n',
	'<C-c>',
	[[:lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>]],
	keymaps.opts
)
-- Press CTRL + l to toggle Logpoint
keymaps.map(
	'n',
	'<C-l>',
	[[:lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log Point Msg: '))<CR>]],
	keymaps.opts
)
-- Pressing F10 to step over
keymaps.map('n', '<F10>', [[:lua require'dap'.step_over()<CR>]], keymaps.opts)
-- Pressing F11 to step into
keymaps.map('n', '<F11>', [[:lua require'dap'.step_into()<CR>]], keymaps.opts)
-- Pressing F12 to step out
keymaps.map('n', '<F12>', [[:lua require'dap'.step_out()<CR>]], keymaps.opts)
-- Press F6 to open REPL
keymaps.map('n', '<F6>', [[:lua require'dap'.repl.open()<CR>]], keymaps.opts)
-- Press dl to run last ran configuration (if you used f5 before it will re run it etc)
keymaps.map('n', 'dl', [[:lua require'dap'.run_last()<CR>]], keymaps.opts)

-- UI
dapui.setup()
keymaps.map('n', '<C-d>', [[:lua require'dapui'.toggle()<CR>]], keymaps.opts)

-- dap fires events, we can listen on them to open UI on certain events
dap.listeners.after.event_initialized['dapui_config'] = function()
	dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
	dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
	dapui.close()
end
