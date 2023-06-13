return {
  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   enable = false,
  --   config = function()
  --     require('rose-pine').setup {
  --       variant = 'moon',
  --     }
  --
  --     vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  --     vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  --   end,
  -- },
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    config = function()
      require('kanagawa').setup {
        compile = true, -- enable compiling the colorscheme
        functionStyle = { italic = true },
        typeStyle = { italic = true },
        transparent = true, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
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
      flavor = 'macchiato',
      transparent_background = true,
      integrations = {
        gitsigns = true,
        cmp = true,
        telescope = true,
      },
    },
  },
}
