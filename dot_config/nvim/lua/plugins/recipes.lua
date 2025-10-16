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
    'Civitasv/cmake-tools.nvim',
    keys = {
      { '<localleader>cc', '<cmd>CMakeRun<cr>', desc = 'Run CMake' },
    },
  },
}
