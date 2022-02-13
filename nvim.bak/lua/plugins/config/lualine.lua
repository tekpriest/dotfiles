local lualine = require("lualine")
local bufferline = require("bufferline")
local colors = require("utils.colors")

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function getWords()
  if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. " word"
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. " words"
    else
      return tostring(vim.fn.wordcount().words) .. " words"
    end
  else
    return ""
  end
end

local function getLines()
  return tostring(vim.api.nvim_win_get_cursor(0)[1]) .. "/" .. tostring(vim.api.nvim_buf_line_count(0))
end

local function getColumn()
  local val = vim.api.nvim_win_get_cursor(0)[2]
  -- pad value to 3 units to stop geometry shift
  return string.format("%03d", val)
end

lualine.setup({
  options = {
    theme = "gruvbox",
    icons_enabled = true,
    component_separators = { " ", " " },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "" },
    -- lualine_b = { "branch" },
    lualine_b = {
      { "branch", icon = "" },
      {
        "diff",
        source = diff_source,
        color_added = "#a7c080",
        color_modified = "#ffdf1b",
        color_removed = "#ff6666",
      },
    },
    lualine_c = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
      function()
        return "%="
      end,
      "filename",
      {
        getWords,
        color = { fg = "#333333", bg = "#eeeeee" },
        separator = { left = "", right = "" },
      },
    },
    -- lualine_x = { "b:gitsigns_status" },
    lualine_x = { "filetype" },
    lualine_y = {},
    lualine_z = {
      { getColumn, padding = { left = 1, right = 0 } },
      { getLines, icon = "", padding = 1 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
    "quickfix",
  },
})

bufferline.setup({
  options = {
    view = "default",
    numbers = "ordinal",
    number_style = "",
    mappings = false,
    buffer_close_icon = "",
    modified_icon = "•",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 18,
    max_prefix_length = 15,
    show_buffer_close_icons = false,
    persist_buffer_sort = true,
    separator_style = { "", "" },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
  },
  highlights = {
    modified = {
      guifg = colors.green,
      guibg = "#0F1E28",
    },
    modified_visible = {
      guifg = "#3C706F",
      guibg = "#16242E",
    },
    modified_selected = {
      guifg = colors.cyan,
      guibg = "#142832",
    },
    fill = {
      guibg = "#0F1E28",
    },
    background = {
      guibg = "#0F1E28",
      guifg = colors.base04,
    },
    tab = {
      guibg = "#0F1E28",
      guifg = colors.base01,
    },
    tab_selected = {
      guibg = "#142832",
    },
    tab_close = {
      guibg = "#0F1E28",
    },
    buffer_visible = {
      guibg = "#16242E",
    },
    buffer_selected = {
      guibg = "#142832",
      guifg = colors.white,
      gui = "NONE",
    },
    indicator_selected = {
      guifg = colors.cyan,
      guibg = "#142832",
    },
    separator = {
      guibg = "#62b3b2",
    },
    separator_selected = {
      guifg = colors.cyan,
      guibg = "#142832",
    },
    separator_visible = {
      guibg = colors.cyan,
    },
    duplicate = {
      guibg = "#0F1E28",
      guifg = colors.base04,
      gui = "NONE",
    },
    duplicate_selected = {
      guibg = "#142832",
      gui = "NONE",
      guifg = colors.white,
    },
    duplicate_visible = {
      guibg = "#16242E",
      gui = "NONE",
    },
  },
})
