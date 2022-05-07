local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
math.randomseed(os.time())

local button = function(sc, txt, key, opts)
	local b = dashboard.button(sc, txt, key, opts)
	b.opts.hl = "Function"
	b.opts.hl_shortcut = "Type"
	return b
end

local pick_color = function()
	local colors = { "String", "Identifier", "Keyword", "Number" }
	return colors[math.random(#colors)]
end

local footer = function()
	-- local total_plugins = #vim.tbl_keys(packer_plugins)
	local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
	return datetime
		-- .. "   "
		-- .. total_plugins
		-- .. " plugins"
		.. "   v"
		.. vim.version().major
		.. "."
		.. vim.version().minor
		.. "."
		.. vim.version().patch
end

dashboard.section.header.val = {
	[[									███        ▄████████  ▄████████    ▄█    █▄             ]],
	[[							▀█████████▄   ███    ███ ███    ███   ███    ███						]],
	[[								 ▀███▀▀██   ███    █▀  ███    █▀    ███    ███						]],
	[[									███   ▀  ▄███▄▄▄     ███         ▄███▄▄▄▄███▄▄					]],
	[[									███     ▀▀███▀▀▀     ███        ▀▀███▀▀▀▀███▀						]],
	[[									███       ███    █▄  ███    █▄    ███    ███						]],
	[[									███       ███    ███ ███    ███   ███    ███						]],
	[[								 ▄████▀     ██████████ ████████▀    ███    █▀							]],
	[[																																				  ]],
	[[        ▄███████▄    ▄████████  ▄█     ▄████████    ▄████████     ███     ]],
	[[		   ███    ███   ███    ███ ███    ███    ███   ███    ███ ▀█████████▄ ]],
	[[		   ███    ███   ███    ███ ███▌   ███    █▀    ███    █▀     ▀███▀▀██ ]],
	[[       ███    ███  ▄███▄▄▄▄██▀ ███▌  ▄███▄▄▄       ███            ███   ▀ ]],
	[[		 ▀█████████▀  ▀▀███▀▀▀▀▀   ███▌ ▀▀███▀▀▀     ▀███████████     ███     ]],
	[[       ███        ▀███████████ ███    ███    █▄           ███     ███     ]],
	[[       ███          ███    ███ ███    ███    ███    ▄█    ███     ███     ]],
	[[			▄████▀        ███    ███ █▀     ██████████  ▄████████▀     ▄████▀   ]],
	[[                    ███    ███                                            ]],
}

dashboard.section.header.opts.hl = pick_color()
dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Constant"

dashboard.section.buttons.val = {
	button("tf", "  File Explorer", "<cmd>NvimTreeOpen<cr>"),
	button("ff", "  Find file"),
	button("fg", "  Find word"),
	button("<Leader>1", "  Open session"),
	button("fn", "  New file", "<cmd>enew<cr>"),
	button("<Leader>v", "  Config", "<cmd>e ~/.config/nvim<cr>"),
	button("<Leader>pu", "  Update plugins", "<cmd>lua require('packer').update()<cr>"),
	button("q", "  Quit", "<Cmd>qa<CR>"),
}

alpha.setup(dashboard.opts)
