return {
  -- Aurora (Ray-x)
  {
    'ray-x/aurora',
    lazy = true,
    config = function()
      vim.g.aurora_italic = 1
      vim.g.aurora_transparent = 1
      -- Remove underlines from common highlight groups
      local highlights = {
        'LspReferenceText',
        'LspReferenceRead',
        'LspReferenceWrite',
        'DiagnosticUnderlineError',
        'DiagnosticUnderlineWarn',
        'DiagnosticUnderlineInfo',
        'DiagnosticUnderlineHint',
        'Visual',
        'Search',
        'IncSearch',
        'CursorLine',
        'Underlined',
      }
      for _, group in ipairs(highlights) do
        vim.api.nvim_set_hl(0, group, { underline = false, undercurl = false })
      end
    end,
  },

  -- TokyoNight (Alternative)
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = { style = 'moon' },
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        compile = true, -- enable compiling the colorscheme
        functionStyle = { italic = true },
        typeStyle = { italic = true },
        transparent = true, -- do not set background color
        dimInactive = false, -- dim inactive window
        statementStyle = { bold = true },
        theme = 'dragon', -- Load "wave" theme when 'background' option is not set
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
                statusline = 'none',
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },
            -- StatusLine = { bg = 'none', fg = 'none' },
            -- StatusLineNC = { bg = 'none', fg = 'none' },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
          }
        end,
      }
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {
      enable = {
        tabby = true,
      },
      styles = {
        transparency = true,
      },
      highlight_groups = {
        StatusLine = { fg = 'love', bg = 'NONE' },
        StatusLineNC = { fg = 'subtle', bg = 'NONE' },
        CurSearch = { fg = 'base', bg = 'leaf', inherit = false },
        Search = { fg = 'text', bg = 'leaf', blend = 20, inherit = false },
        TelescopeBorder = { fg = 'highlight_high', bg = 'none' },
        TelescopeNormal = { bg = 'none' },
        TelescopePromptNormal = { bg = 'base' },
        TelescopeResultsNormal = { fg = 'subtle', bg = 'none' },
        TelescopeSelection = { fg = 'text', bg = 'base' },
        TelescopeSelectionCaret = { fg = 'rose', bg = 'rose' },
      },
    },
  },
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'kanagawa',
    },
  },
}
