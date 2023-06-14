return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
    -- { 'nvim-telescope/telescope.nvim' },
  },
  ft = { 'go', 'cpp', 'c' },
  -- init = function()
  --   -- load refactoring Telescope extension
  --   require('telescope').load_extension 'refactoring'
  -- end,
  opts = {
    prompt_func_return_type = {
      go = true,
      cpp = true,
      c = true,
      h = true,
      hpp = true,
      cxx = true,
    },
    prompt_func_param_type = {
      go = true,
      cpp = true,
      c = true,
      h = true,
      hpp = true,
      cxx = true,
    },
  },
  config = function(_, opts)
    require('refactoring').setup(opts)

    -- -- Remaps for the refactoring operations currently offered by the plugin
    -- vim.api.nvim_set_keymap(
    --   'v',
    --   '<leader>re',
    --   [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
    --   { noremap = true, silent = true, expr = false }
    -- )
    -- vim.api.nvim_set_keymap(
    --   'v',
    --   '<leader>rf',
    --   [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
    --   { noremap = true, silent = true, expr = false }
    -- )
    -- vim.api.nvim_set_keymap(
    --   'v',
    --   '<leader>rv',
    --   [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
    --   { noremap = true, silent = true, expr = false }
    -- )
    -- vim.api.nvim_set_keymap(
    --   'v',
    --   '<leader>ri',
    --   [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
    --   { noremap = true, silent = true, expr = false }
    -- )
    --
    -- -- Extract block doesn't need visual mode
    -- vim.api.nvim_set_keymap(
    --   'n',
    --   '<leader>rb',
    --   [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
    --   { noremap = true, silent = true, expr = false }
    -- )
    -- vim.api.nvim_set_keymap(
    --   'n',
    --   '<leader>rbf',
    --   [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
    --   { noremap = true, silent = true, expr = false }
    -- )
    --
    -- -- Inline variable can also pick up the identifier currently under the cursor without visual mode
    -- vim.api.nvim_set_keymap(
    --   'n',
    --   '<leader>ri',
    --   [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
    --   { noremap = true, silent = true, expr = false }
    -- )
  end,
}
