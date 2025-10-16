return {
  {
    'jedrzejboczar/possession.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {
      autosave = {
        current = true,
        cwd = function()
          return not require('possession.session').exists(
            require('possession.paths').cwd_session_name()
          )
        end,
        on_quit = true,
        on_load = true,
      },
      autoload = 'auto_cwd',
    },
    init = function()
      require('telescope').load_extension 'possession'
    end,
  },
  {
    'gennaro-tedesco/nvim-possession',
    dependencies = {
      'ibhagwan/fzf-lua',
      'tiagovla/scope.nvim',
    },
    opts = {
      autoload = true,
      autoswitch = { enable = true },
      save_hook = function()
        vim.cmd [[ScopeSaveState]] -- scope.nvim
      end,
      post_hook = function()
        vim.cmd [[ScopeLoadState]] -- scope.nvim
      end,
    },
    keys = {
      -- stylua: ignore start
      { '<leader>ql', function() require('nvim-possession').list() end, desc = 'list sessions' },
      { '<leader>qn', function() require('nvim-possession').new() end, desc = 'create new session' },
      { '<leader>qu', function() require('nvim-possession').update() end, desc = 'update current session' },
      { '<leader>qd', function() require('nvim-possession').delete() end, desc = 'delete selected session' },
      -- stylua: ignore end
    },
  },
  {
    'tiagovla/scope.nvim',
    lazy = false,
    config = true,
    init = function()
      require('telescope').load_extension 'scope'
    end,
    keys = {
      { '<leader>qb', '<cmd>Telescope scope buffers<cr>', desc = 'list workspace buffers' },
    },
  },
}
