local Utils = {}

-- Sets the given keymap with the given properties
-- @param mode - string
-- @param key - string
-- @param action - string
-- @param opts - object
function Utils.setKey(mode, key, action, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	mode = mode or "n"
	vim.api.nvim_set_keymap(mode, key, action, options)
end

-- Sets the given keymap with the given properties for buffer
-- @param mode - string
-- @param key - string
-- @param action - string
-- @param opts - object
function Utils.setBufKey(buf, mode, key, action)
	local options = { noremap = true, silent = true }
	mode = mode or "n"
	vim.api.nvim_buf_set_keymap(buf, mode, key, action, options)
end

Utils.setKey("n", "<Esc>", "<cmd>nohl<CR>")

Utils.setKey("v", "<", "<gv")
Utils.setKey("v", ">", ">gv")

Utils.setKey("n", "Q", "<nop>")
Utils.setKey("n", "q", "<nop>")

Utils.setKey("i", "<C-p>", "<cmd>Telescope buffers<CR>")
Utils.setKey("n", "<C-p>", "<cmd>Telescope buffers<CR>")

Utils.setKey("n", "<leader>sa", "ggVG<c-$>")
Utils.setKey("n", "<leader>n", "<cmd>enew<CR>")

Utils.setKey("n", "Y", "y$")
Utils.setKey("n", "<Tab>", "<cmd>bnext<CR>")
Utils.setKey("n", "<S-Tab>", "<cmd>bprevious<CR>")

-- Line bubbling
Utils.setKey("n", "<A-k>", "<cmd>m .-2<CR>==")
Utils.setKey("n", "<A-j>", "<cmd>m .+1<CR>==")
Utils.setKey("v", "<A-j>", ":m '>+1<CR>==gv=gv")
Utils.setKey("v", "<A-k>", ":m '<-2<CR>==gv=gv")

-- Cycle through 9 open buffers
for i = 1, 9 do
	Utils.setKey("n", "<leader>" .. i, "<cmd>lua require'Bufferline'.go_to_buffer(" .. i .. ")<CR>")
end

return Utils
