local dashboard = require("alpha.themes.dashboard")
local plugins = require(".plugins")
math.randomseed(os.time())

local function button(sc, txt, key, opts)
  local b = dashboard.button(sc, txt, key, opts)
  b.opts.hl = "Function"
  b.opts.hl_shortcut = "Type"
  return b
end

local function pick_color()
  local colors = { "String", "Identifier", "Keyword", "Number" }
  return colors[math.random(#colors)]
end

local function footer()
  local total_plugins = #vim.tbl_keys(plugins)
  local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
  return datetime
    .. "   "
    .. total_plugins
    .. " plugins"
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

dashboard.section.buttons.val = {
  button("<Leader>tf", "  File Explorer"),
  button("<Leader>p", "  Find file"),
  button("<Leader>tg", "  Find word"),
  button("<Leader>1", "  Open session"),
  button("<Leader>n", "  New file"),
  button("<Leader>v", "  Config"),
  button("<Leader>pu", "  Update plugins"),
  button("q", "  Quit", "<Cmd>qa<CR>"),
}

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Constant"

require("alpha").setup(dashboard.opts)
