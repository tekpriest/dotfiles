return {
  {
    'nvim-orgmode/orgmode',
    dependencies = {
      'akinsho/org-bullets.nvim',
      'lukas-reineke/headlines.nvim',
    },
    opts = {
      org_agenda_files = { '~/Code/org/*' },
      org_default_notes_file = '~/Documents/org/refile.org',
    },
    config = function()
      require('orgmode').setup_ts_grammar()

      require('org-bullets').setup {
        concealcursor = true,
        symbols = {
          headlines = { '◉', '○', '✸', '✿' },
        },
      }

      vim.cmd [[highlight Headline1 guibg=#1e2718]]
      vim.cmd [[highlight Headline2 guibg=#21262d]]
      vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
      vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]

      require('headlines').setup {
        org = {
          headline_highlights = { 'Headline1', 'Headline2' },
        },
      }
      vim.opt.conceallevel = 2
      vim.opt.concealcursor = 'nc'
    end,
  },
}
