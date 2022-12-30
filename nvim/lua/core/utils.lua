local M = {}

M.pick = function(item)
	local item_ok, item_found = pcall(item)
	if not item_ok then
		return
	end
	return item_found
end

return M
