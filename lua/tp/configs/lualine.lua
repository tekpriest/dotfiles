local lualine = require("lualine")
local gps = require("nvim-gps")
--local copilot = require("Copilot")
-- print(copilot)

lualine.setup({
  options = {
    disabled_filetypes = { "NvimTree", "dashboard", "Outline" },
    theme = "kanagawa",
    icons_enabled = true,
    component_separators = { " ", " " },
    section_separators = { left = "", right = "" },
    globalstatus = true,
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
      {
        gps.get_location,
        cond = gps.is_available,
      },
    },
    lualine_y = {
      { "location" },
      -- {
      --   function()
      --     if vim.lsp.buf_get_clients() then
      --       return require("lsp-status").status()
      --     end
      --     return ""
      --   end,
      -- },
    },
    lualine_z = {
      -- { "progress" },
      function()
        local cmd =
          vim.split(vim.api.nvim_exec("Copilot status", true), "\n")[1]
        if cmd == "Copilot: Enabled and online" then
          return "🦾"
        else
          return ""
        end
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
