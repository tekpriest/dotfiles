return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.1',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  opts = function()
    local actions = require 'telescope.actions'

    local dropdown = {
      theme = 'dropdown',
      previewer = false,
      layout_config = { height = 0.5, width = 0.8 },
    }

    local ivy = {
      theme = 'ivy',
      previewer = false,
      border = false,
      layout_config = { height = 10 },
    }

    return {
      defaults = {
        selection_strategy = 'reset',
        scroll_strategy = 'cycle',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            height = 0.9,
            preview_cutoff = 40,
            width = 0.84,
          },
          bottom_pane = {
            height = 25,
            preview_cutoff = 120,
            prompt_position = 'top',
          },
          center = {
            height = 0.4,
            preview_cutoff = 40,
            prompt_position = 'top',
            width = 0.5,
          },
          cursor = {
            height = 0.9,
            preview_cutoff = 40,
            width = 0.8,
          },
          vertical = {
            prompt_position = 'top',
            height = 0.8,
            preview_cutoff = 40,
            width = 0.8,
          },
        },
        path_display = { 'smart' },
        find_command = {
          'rg',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
        },
        prompt_prefix = '  ',
        entry_prefix = '  ',
        color_devicons = true,
        set_env = { ['COLORTERM'] = 'truecolor' },
        mappings = {
          i = {
            ['<CR>'] = actions.select_default + actions.center,
          },
          n = {
            ['q'] = actions.close,
          },
        },
        initial_mode = 'insert',
      },
      pickers = {
        buffers = dropdown,
        find_files = dropdown,
        lsp_references = ivy,
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        ['ui-select'] = { require('telescope.themes').get_dropdown {} },
        file_browser = {
          hidden = true,
          grouped = true,
          cwd_to_path = true,
        },
      },
    }
  end,
  cmd = 'Telescope',
  keys = {
    { '<leader><space>', '<cmd>Telescope find_files<cr>', desc = 'find files' },
    {
      '<leader>fw',
      '<cmd>Telescope live_grep<cr>',
      desc = 'live text search',
    },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', 'list buffers' },
  },
  init = function()
    require('telescope').load_extension 'fzf'
  end,
}
