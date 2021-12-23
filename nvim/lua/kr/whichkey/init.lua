local wk = require("which-key")

wk.setup({
	plugins = {
		marks = false,
		registers = false,
	},
	ignore_missing = true,
})

wk.register({
	-- Single mappings
	["/"] = { "<cmd>NvimTreeToggle<CR>", "Open Explorer" },
	s = {"<cmd>SymbolsOutline<CR>","Toggle Outline"},
	c = { "<cmd>CommentToggle<CR>", "Comment Toggle" },
	f = { "<cmd>Format<CR>", "Format Buffer" },
	-- Group mappings
	j = {
		name = "JsDoc",
		s = { "<cmd>JsDoc<CR>", "JSDoc" },
	},
	l = {
		name = "Language",
		h = { "<cmd>TSHighlightCapturesUnderCursor<CR>", "Highlight under cursor" },
	},
	m = {
		name = "Markdown",
		t = { "<cmd>TableModeToggle<CR>", "Toggle Table" },
	},
	p = {
		name = "Packer",
		u = { "<cmd>PackerUpdate<CR>", "Update Packer" },
		s = { "<cmd>PackerSync<CR>", "Packer Sync" },
	},
	t = {
		name = "Telescope",
		f = { "<cmd>lua require('kr.telescope').find_files()<cr>", "Find Files" },
		g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
		c = { "<cmd>lua require('kr.telescope').colors()<CR>", "Change Colorscheme" },
		b = { "<cmd>Telescope buffers<cr>", "Buffers" },
	},
	-- Trouble
	x = {
		nme = "Trouble",
		x = { "<cmd>Trouble<CR>" },
		d = { "<cmd>Trouble document_diagnostics<CR>" },
		l = { "<cmd>Trouble loclist<CR>" },
		q = { "<cmd>Trouble quickfix<CR>" },
	},
}, { prefix = "<leader>", nowait = true })
