local lualine = TP.require("lualine")
local bufferline = require("bufferline")

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

lualine.setup({
  options = {
    disabled_filetypes = { "NvimTree", "dashboard", "Outline" },
    theme = "kanagawa",
    icons_enabled = true,
    component_separators = { " ", " " },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {},
    lualine_b = {
      { "branch", icon = "", gui = "bold" },
      {
        "diff",
        symbols = { added = " ", modified = "柳", removed = " " },
        diff_color = {
          added = { fg = "#a7c080" },
          modified = { fg = "#ffdf1b" },
          removed = { fg = "#ff6666" },
        },
      },
    },
    lualine_c = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = " ",
        },
      },
      function()
        return "%="
      end,
      "filename",
      {
        color = { fg = "#333333", bg = "#eeeeee" },
        separator = { left = "", right = "" },
      },
    },
    lualine_x = {
      { "filetype" },
    },
    lualine_y = {
      { "location" },
      {
        function()
          if vim.lsp.buf_get_clients() then
            return require("lsp-status").status()
          end
          return ""
        end,
      },
    },
    lualine_z = {
      { "progress" },
      function()
        local b = vim.api.nvim_get_current_buf()
        if next(vim.treesitter.highlighter.active[0]) then
          return " 綠TS"
        end
        return ""
      end,
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    -- lualine_z = {},
  },
  tabline = {},
  extensions = {
    "quickfix",
  },
})
