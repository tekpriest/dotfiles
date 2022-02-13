local Utils = {}

function Utils.autocmd(event, trigger, actions)
	local cmd = string.format("autocmd %s %s %s", event, trigger, actions)
	vim.cmd(cmd)
end

return Utils
