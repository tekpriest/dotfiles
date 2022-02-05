local npairs = TP.require('nvim-autopairs')

npairs.setup{
  check_ts = true,
  ts_config = {
    lua = {'string','source'},
    javascript = {'string','template_string'},
    java = false
  },
  disable_filetype = {"TelescopePrompt","spectre_panel"},
  fast_wrap = {
    map = "<M-e>",
    chars = {"{","[","(", '"', "'"},
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0,
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
  }
}

local cmp_autopairs = TP.require("nvim-autopairs.completion.cmp")
local cmp = TP.require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {map_char = {tex = ""}})
