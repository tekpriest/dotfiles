return {
  {
    'folke/snacks.nvim',
    opts = {
      scroll = { enabled = false },
      words = { enabled = false },
      picker = {
        layout = {
          preset = 'ivy',
        },
      },
    },
  },
  {
    'folke/noice.nvim',
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      incremental_selection = { enable = false },
    },
  },
  {
    'RRethy/vim-illuminate',
    init = function()
      vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'TelescopeResultsLineNr' })
      vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'TelescopeResultsLineNr' })
      vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'TelescopeResultsLineNr' })
    end,
  },
  {
    'Civitasv/cmake-tools.nvim',
    keys = {
      { '<localleader>cc', '<cmd>CMakeRun<cr>', desc = 'Run CMake' },
    },
  },
}
