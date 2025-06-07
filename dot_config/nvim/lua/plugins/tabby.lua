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
  end,
  enabled = false,
  lazy = false,
  opts = {
    tabline = function(line)
      local tabname = function(tabid)
        return vim.api.nvim_tabpage_get_number(tabid)
      end
      local cwd = function()
        return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
      end
      local filename = require 'tabby.feature.win_name'

      return {
        hl = theme.head,
        layout = 'active_wins_at_tail',
        head = {
          { cwd, hl = theme.head },
          { '', hl = theme.head },
        },
        active_tab = {
          label = function(tabid)
            return {
              '  ' .. tabname(tabid) .. ' ',
              hl = theme.current_tab,
            }
          end,
          left_sep = { '', hl = theme.fill },
          right_sep = { '', hl = theme.fill },
        },
        inactive_tab = {
          label = function(tabid)
            return {
              '  ' .. tabname(tabid) .. ' ',
              hl = theme.tab,
            }
          end,
          -- left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
          -- right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
        },
        top_win = {
          label = function(winid)
            return {
              '  ' .. filename.get(winid, { mode = 'unique' }) .. ' ',
              hl = theme.win,
            }
          end,
          left_sep = { '', hl = theme.fill },
          right_sep = { '', hl = theme.fill },
        },
        win = {
          label = function(winid)
            return {
              '  ' .. filename.get(winid, { mode = 'unique' }) .. ' ',
              hl = theme.win,
            }
          end,
          left_sep = { '', hl = theme.fill },
          right_sep = { '', hl = theme.fill },
        },
        tail = {
          { '', hl = theme.fill },
          { '  ', hl = theme.tail },
        },
      }
    end,
  },
}
