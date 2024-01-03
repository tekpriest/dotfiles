local Utils = require 'core.utils'
local autocmd = vim.api.nvim_create_autocmd

vim.defer_fn(function()
  autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank { higroup = 'Visual', timeout = 100 }
    end,
    group = Utils.augroup 'highlight_yank',
    pattern = '*',
  })

  autocmd('BufReadPost', {
    group = Utils.augroup 'last_loc',
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  autocmd('FileType', {
    group = Utils.augroup 'close_with_q',
    pattern = {
      'OverseerForm',
      'OverseerList',
      'checkhealth',
      'floggraph',
      'fugitive',
      'git',
      'help',
      'lspinfo',
      'man',
      'neotest-output',
      'neotest-summary',
      'qf',
      'query',
      'spectre_panel',
      'startuptime',
      'toggleterm',
      'tsplayground',
      'vim',
      'neoai-input',
      'neoai-output',
      'netrw',
      'notify',
      'Codi!!',
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end,
  })

  autocmd({ 'BufWinEnter' }, {
    group = Utils.augroup 'auto_format_options',
    callback = function()
      vim.cmd 'set formatoptions-=cro'
    end,
  })

  -- resize splits if window got resized
  autocmd({ 'VimResized' }, {
    group = Utils.augroup 'resize_splits',
    callback = function()
      vim.cmd 'tabdo wincmd ='
    end,
  })

  -- set .mdx and .md files to markdown
  autocmd('FileType', {
    pattern = { 'gitcommit', 'markdown' },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

  -- Check if we need to reload the file when it changed
  autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = Utils.augroup 'checktime',
    command = 'checktime',
  })

  autocmd({ 'BufWritePre' }, {
    group = Utils.augroup 'auto_create_dir',
    callback = function(event)
      if event.match:match '^%w%w+://' then
        return
      end
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end,
  })

  -- open help window in a vertical split to the right
  autocmd('BufWinEnter', {
    group = Utils.augroup 'help_window_right',
    pattern = { '#.txt' },
    callback = function()
      if vim.o.filetype == 'help' then
        vim.cmd.wincmd 'L'
      end
    end,
  })

  autocmd({ 'CursorHold' }, {
    group = Utils.augroup 'show_diagnostics',
    callback = function(_, bufnr)
      for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).zindex then
          return
        end
      end
      vim.diagnostic.open_float(bufnr, {
        scope = 'cursor',
        focusable = false,
        close_events = {
          'CursorMoved',
          'CursorMovedI',
          'BufHidden',
          'InsertCharPre',
          'WinLeave',
        },
      })
    end,
  })

  autocmd('FileType', {
    group = Utils.augroup 'buf_check',
    pattern = { 'NeogitCommitMessage' },
    command = 'startinsert | 1',
  })

  autocmd({ 'BufNewFile', 'BufReadPost' }, {
    group = Utils.augroup 'set_eex_mjml',
    pattern = { '*.mjml' },
    command = [[set filetype=html]],
  })

  -- autocmd('BufReadPost', {
  --   group = Utils.augroup 'set_maximize_buffer_keys',
  --   pattern = '*',
  --   callback = function()
  --     local is_true = vim.fn.winwidth(0) == vim.fn.winwidth '%'
  --       and vim.fn.winheight(0) == vim.fn.winheight '%'
  --     if is_true then
  --       vim.api.nvim_set_keymap(
  --         'n',
  --         '<C-w>z',
  --         [[<cmd>wincmd =<cr>]],
  --         { silent = true, noremap = true }
  --       )
  --     else
  --       vim.api.nvim_set_keymap(
  --         'n',
  --         '<C-w>z',
  --         [[<cmd>wincmd _  | wincmd |<cr>]],
  --         { silent = true, noremap = true }
  --       )
  --     end
  --   end,
  -- })
end, 10)
