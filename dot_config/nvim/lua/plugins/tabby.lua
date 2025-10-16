local theme = {
  head = 'TabLine',
  fill = 'TabLineFill',
  current_tab = 'TabLineSel',
  tab = 'TabLine',
  win = 'TabLine',
  tail = 'TabLine',
}

return {
  'nanozuki/tabby.nvim',
  init = function()
    vim.o.showtabline = 2
    vim.opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'
  end,
  enabled = false,
  lazy = false,
  event = 'VeryLazy',
  opts = {
    line = function(line)
      return {
        {
          { '  ', hl = theme.head },
          line.sep('', theme.head, theme.fill),
        },
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab
          return {
            line.sep('', hl, theme.fill),
            tab.is_current() and '' or '󰆣',
            tab.number(),
            tab.name(),
            tab.close_btn '',
            line.sep('', hl, theme.fill),
            hl = hl,
            margin = ' ',
          }
        end),
        line.spacer(),
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
          return {
            line.sep('', theme.win, theme.fill),
            win.is_current() and '' or '',
            win.buf_name(),
            line.sep('', theme.win, theme.fill),
            hl = theme.win,
            margin = ' ',
          }
        end),
        {
          line.sep('', theme.tail, theme.fill),
          { '  ', hl = theme.tail },
        },
        hl = theme.fill,
      }
    end,
  },
  config = function(_, opts)
    require('tabby').setup(opts)
  end,
}
