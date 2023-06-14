return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.1',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you have trouble with this installation, refer to the README for telescope-fzf-native.
      build = 'make',
    },
    {
      'ThePrimeagen/refactoring.nvim',
    },
  },
  opts = function()
    local actions = require 'telescope.actions'
    local sorters = require 'telescope.sorters'
    local previewers = require 'telescope.previewers'

    return {
      defaults = {
        mappings = {
          -- i = {
          --   ['<esc>'] = actions.close,
          -- },
          n = {
            ['q'] = actions.close,
          },
        },
        prompt_prefix = '  ',
        selection_caret = '  ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = sorters.get_fuzzy_file,
        file_ignore_patterns = { 'node_modules', 'dist', '.git/' },
        generic_sorter = sorters.get_generic_fuzzy_sorter,
        path_display = { 'smart' },
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = false,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = previewers.buffer_previewer_maker,
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--trim',
        },
      },
      pickers = {
        buffers = {
          prompt_prefix = '﬘ ',
        },
        commands = {
          prompt_prefix = ' ',
        },
        git_files = {
          prompt_prefix = ' ',
          show_untracked = true,
        },
        find_files = {
          prompt_prefix = ' ',
          find_command = { 'rg', '--files', '--hidden' },
        },
      },
    }
  end,
  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'refactoring'
  end,
}
