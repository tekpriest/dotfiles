return {
  'nvim-orgmode/orgmode',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter', lazy = true },
  },
  event = 'VeryLazy',
  init = function()
    require('orgmode').setup_ts_grammar()
  end,
  opts = {
    org_agenda_files = '~/Code/personal/notes/##/#',
    org_default_notes_file = '~/Code/personal/notes/refile.org',
  },
}
