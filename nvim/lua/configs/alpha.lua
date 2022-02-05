local alpha = TP.require("alpha")
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
  local total_plugins = #vim.tbl_keys(packer_plugins)
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
dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Constant"

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

alpha.setup(dashboard.opts)
