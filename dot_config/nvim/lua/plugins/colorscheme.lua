return {
  {
    'rebelot/kanagawa.nvim',
    event = 'User ColorSchemeLoad',
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
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    opts = {
      flavour = 'mocha',
      transparent_background = true,
      no_underline = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        navic = { enabled = true, custom_bg = 'lualine' },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {
      styles = {
        transparency = true,
      },
      highlight_groups = {
        Comment = { italic = true },
        NormalFloat = { bg = 'none' },
        TelescopeBorder = { fg = 'highlight_high', bg = 'none' },
        TelescopeNormal = { bg = 'none' },
        TelescopePromptNormal = { bg = 'none' },
        TelescopeResultsNormal = { fg = 'subtle', bg = 'none' },
        TelescopeSelection = { fg = 'text', bg = 'none' },
        TelescopeSelectionCaret = { fg = 'rose', bg = 'rose' },
        CurSearch = { fg = 'base', bg = 'leaf', inherit = false },
        Search = { fg = 'text', bg = 'leaf', blend = 20, inherit = false },
        FloatBorder = { bg = 'none' },
        FloatTitle = { bg = 'none' },
        PmenuSel = { fg = 'none' },
      },
    },
  },
  {
    'vague2k/vague.nvim',
    opts = {
      transparent = true,
      style = { functions = 'italic' },
      on_highlights = function(_, colors)
        return {
          StatusLine = 'none',
          StatusLineNC = 'none',
        }
      end,
    },
    config = function(_, opts)
      require('vague').setup(opts)
    end,
  },
  {
    'LazyVim/LazyVim',
    opts = { colorscheme = 'vague' },
  },
  -- {
  --   'ray-x/aurora',
  --   init = function()
  --     vim.g.aurora_italic = 1
  --     vim.g.aurora_transparent = 1
  --     vim.g.aurora_bold = 1
  --
  --     vim.cmd.colorscheme 'aurora'
  --   end,
  -- },
}
