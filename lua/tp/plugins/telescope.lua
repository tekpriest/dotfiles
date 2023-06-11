return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.1',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local actions = require 'telescope.actions'

    require('telescope').setup {
      defaults = {
        mappings = {
          -- i = {
          --   ['<esc>'] = actions.close,
          -- },
          n = {
            ['q'] = actions.close,
          },
        },
        prompt_prefix = '   ',
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
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        file_ignore_patterns = { 'node_modules', 'dist' },
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        path_display = { 'truncate' },
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = false,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
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
    }
    local builtin = require 'telescope.builtin'
    -- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    -- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    -- vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
    -- vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
    -- vim.keymap.set('n', '<leader>gs', builtin.lsp_workspace_symbols, {})
    -- vim.keymap.set('n', '<leader>gl', builtin.diagnostics, {})
    -- vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, {})
    -- vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, {})
    -- vim.keymap.set('n', '<leader>gD', builtin.lsp_type_definitions, {})
  end,
}
