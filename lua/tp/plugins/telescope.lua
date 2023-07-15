return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.1',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    {
      'ThePrimeagen/refactoring.nvim',
    },
    { 'nvim-telescope/telescope-file-browser.nvim' },
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
        file_browser = ivy,
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
    { '<leader><space>', '<cmd>Telesope find_files<cr>', desc = 'Telescope' },
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'refactoring'
    require('telescope').load_extension 'file_browser'

    -- keymaps
    local wk = require 'which-key'
    wk.register({
      ['<space>'] = { '<cmd>Telescope find_files<cr>', 'find files' },
      -- files
      f = {
        name = 'file',
        f = { '<cmd>Telescope find_files<cr>', 'find files' },
        b = { '<cmd>Telescope buffers<cr>', 'list buffers' },
        w = { '<cmd>Telescope live_grep<cr>', 'live text search' },
        g = { '<cmd>Telescope live_grep<cr>', 'live text search' },
        t = { '<cmd>:TodoTelescope<cr>', 'todos' },
      },
    }, {
      prefix = '<leader>',
    })
  end,
  -- keys = { },
}
