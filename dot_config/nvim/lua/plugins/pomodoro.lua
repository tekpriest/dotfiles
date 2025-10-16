return {
  'epwalsh/pomo.nvim',
  version = '*',
  lazy = true,
  cmd = { 'TimerStart', 'TimerRepeat', 'TimerSession' },
  dependencies = { 'rcarriga/nvim-notify' },
  init = function()
    require('telescope').load_extension 'pomodori'
  end,
  opts = {
    notifiers = {
      {
        name = 'Default',
        opts = { sticky = false },
      },
      { name = 'System' },
    },
  },
  keys = {
    {
      '<leader>pt',
      [[:lua require('telescope').extensions.pomodori.timers() <CR>]],
      desc = 'Manage Pomodoro Timers',
    },
  },
}
