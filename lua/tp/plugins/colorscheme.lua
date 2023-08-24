return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    event = 'VeryLazy',
    config = function()
      require('rose-pine').setup {
        variant = 'moon',
        disable_background = true,
        disable_float_background = true,
        highlight_groups = {
          StatusLine = { fg = 'love', bg = 'love', blend = 10 },
          StatusLineNC = { fg = 'subtle', bg = 'surface' },
          TelescopeBorder = { fg = 'highlight_high', bg = 'none' },
          TelescopeNormal = { bg = 'none' },
          TelescopePromptNormal = { bg = 'base' },
          TelescopeResultsNormal = { fg = 'subtle', bg = 'none' },
          TelescopeSelection = { fg = 'text', bg = 'base' },
          TelescopeSelectionCaret = { fg = 'rose', bg = 'rose' },
          Comment = { italic = true },
        },
      }
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    event = 'VeryLazy',
    config = function()
      require('kanagawa').setup {
        compile = true, -- enable compiling the colorscheme
        functionStyle = { italic = true },
        typeStyle = { italic = true },
        transparent = true, -- do not set background color
        dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        theme = 'dragon', -- Load "wave" theme when 'background' option is not set
      }
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    event = 'VeryLazy',
    opts = {
      flavor = 'macho',
      transparent_background = true,
      integrations = {
        gitsigns = true,
        cmp = true,
        telescope = true,
      },
    },
    init = function()
      -- vim.cmd [[colorscheme catppuccin]]
    end,
  },
  {
    'folke/tokyonight.nvim',
    name = 'tokyonight',
    event = 'VeryLazy',
    opts = {
      style = 'night',
      styles = {
        keywords = { italic = true },
        Comment = { italic = true },
      },
      sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' },
    },
    init = function()
      vim.cmd [[colorscheme tokyonight]]
    end,
  },
  {
    'sam4llis/nvim-tundra',
    name = 'tundra',
    event = 'VeryLazy',
    config = function()
      require('nvim-tundra').setup {
        transparent_background = true,
        dim_inactive_windows = {
          enabled = true,
        },
        syntax = {
          comments = { bold = true, italic = true },
          constants = { bold = true },
          fields = { bold = true },
          functions = { bold = true },
          keywords = { bold = true, italic = true },
          numbers = { bold = true },
          operators = { bold = true },
          types = { italic = true },
        },
        plugins = {
          lsp = true,
          semantic_tokens = true,
          treesitter = true,
          -- telescope = true,
          nvimtree = true,
          cmp = true,
          context = true,
          dbui = true,
          gitsigns = true,
          neogit = true,
          textfsm = true,
        },
      }
    end,
  },
  {
    'ray-x/aurora',
    event = 'VeryLazy',
    init = function()
      local g = vim.g
      vim.cmd [[set termguicolors]]
      g.aurora_italic = 1
      g.aurora_transparent = 1
      g.aurora_bold = 1
      g.aurora_darker = 1

      -- vim.cmd [[colorscheme aurora]]
    end,
  },
}
