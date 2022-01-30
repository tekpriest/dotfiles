local fn = vim.fn
local api = vim.api
local fmt = string.format

_G.__tp_global_callbacks = __tp_global_callbacks or {}
_G.tp = {
  _store = __tp_global_callbacks,
  mappings = {},
}

do
  local pallete = {
    purple_red = "#990147",
    dark_red =   "#953553",
    light_red = "#e40078",
    dark_orange = "#FF922B",
		green = "#98c379",
		bright_yellow = "#FAB005",
		light_yellow = "#e5c07b",
		dark_blue = "#4e88ff",
		magenta = "#c678dd",
		comment_grey = "#7f00f",
		grey = "#3E4556",
		whitesmoke = "#626262",
		bright_blue = "#51afef",
		teal = "#15AABF",

  }
  tp.style = {
    icons = {
      error = "✗",
			warn = "",
			info = "",
			hint = "",
    },
    lsp = {
      colors = {
        error = pallete.purple_red,
        warn = pallete.dark_orange,
        hint = pallete.bright_yellow,
        info = pallete.teal
      },
      	kind_highlights = {
				Text = "String",
				Method = "Method",
				Function = "Function",
				Constructor = "TSConstructor",
				Field = "Field",
				Variable = "Variable",
				Class = "Class",
				Interface = "Constant",
				Module = "Include",
				Property = "Property",
				Unit = "Constant",
				Value = "Variable",
				Enum = "Type",
				Keyword = "Keyword",
				File = "Directory",
				Reference = "Preproc",
				Constant = "Constant",
				Struct = "Type",
				Event = "Variable",
				Operator = "Operator",
				TypeParameter = "Type",
			},
      kinds = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "ﰠ",
				Variable = "",
				Class = "ﴯ",
				Interface = "",
				Module = "",
				Property = "ﰠ",
				Unit = "塞",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "פּ",
				Event = "",
				Operator = "",
				TypeParameter = "",
			},
    },
    pallete = pallete
  }
end

-- set options
function tp.add_config(option, value)
  if option == nil then
    vim.notify(fmt("%S",error("empty config key")))
    return
  end
  vim.opt[option] = value
end

---A terser proxy for `nvim_replace_termcodes`
---@param str string
---@return any
function tp.replace_termcodes(str)
	return api.nvim_replace_termcodes(str, true, true, true)
end

function tp.executable(e)
  return fn.executable(e) > 0
end

function tp.safe_require(module, opts)
  opts = opts or {silent=false}
  local ok,result = pcall(require, module)
  if not ok and not opts.silent then
    vim.notify(result, L.ERROR, {
      title = fmt("Error requiring: %s", module)})
  end
  return ok, result
end
