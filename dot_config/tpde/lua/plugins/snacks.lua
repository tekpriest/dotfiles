return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = false },
    scratch = { enabled = true },
    styles = { enabled = true },
    terminal = { enabled = true },
  },
  keys = {
		-- stylua: ignore start
    { '<leader>.', function() Snacks.scratch() end, desc = 'Open scratch' },
    { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select scratch' },
		{ '<leader>ft', function() Snacks.terminal.toggle() end, desc='Toggle terminal' },
		{ '<leader>gf', function() Snacks.picker.git_log_file() end, desc='Git current file history' },
		{ '<leader>gl', function() Snacks.picker.git_log() end, desc='Git log' },
    -- stylua: ignore end
  },
}
