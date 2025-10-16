return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  opts = {
    defaults = {
      layout_strategy = 'horizontal',
      layout_config = { prompt_position = 'top' },
      sorting_strategy = 'ascending',
      winblend = 0,
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    },
  },
  init = function()
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
  end,
  -- stylua: ignore start
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = '[S]earch [F]iles' },
    { '<leader><space>', '<cmd>Telescope find_files<cr>', desc = '[S]earch [S]elect Telescope' },
    { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = '[S]earch current [W]ord' },
    { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = '[S]earch by [G]rep' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = '[ ] Find existing buffers' },
  },
  -- stylua: ignore end
}
