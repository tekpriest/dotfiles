vim.defer_fn(function()
  local api = vim.api
  local autocmd = api.nvim_create_autocmd
  local Utils = require 'tp.utils'
  -- local misc_aucmd =
  --   vim.api.nvim_create_augroup('misc_aucmds', { clear = true })

  -- resize splits if window got resized
  autocmd({ 'VimResized' }, {
    group = Utils.augroup 'resize_splits',
    callback = function()
      vim.cmd 'tabdo wincmd ='
    end,
  })

  autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank { higroup = 'Visual', timeout = 100 }
    end,
    group = Utils.augroup 'highlight_yank',
  })

  -- set cursor to the last position when opening a buffer
  -- go to last loc when opening a buffer
  autocmd('BufReadPost', {
    group = Utils.augroup 'last_loc',
    callback = function()
      local exclude = { 'gitcommit' }
      local buf = vim.api.nvim_get_current_buf()
      if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
        return
      end
      local mark = vim.api.nvim_buf_get_mark(buf, '"')
      local lcount = vim.api.nvim_buf_line_count(buf)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  -- autosource tmux
  autocmd('BufWritePost', {
    pattern = { '*tmux.conf' },
    command = "execute 'silent !tmux source <afile> --silent'",
  })

  -- autosource fish
  autocmd('BufWritePost', {
    pattern = { 'config.fish' },
    command = "execute 'silent !source <afile> --silent'",
  })

  -- set .mdx and .md files to markdown
  autocmd('FileType', {
    pattern = { 'gitcommit', 'markdown' },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

  -- set .conf files to sh
  -- autocmd({ 'BufRead' }, {
  --   pattern = { '*.conf' },
  --   callback = function()
  --     vim.cmd [[set filetype=sh]]
  --   end,
  -- })
  --
  --  set env files to conf
  autocmd({ 'BufRead' }, {
    pattern = { '*.env*' },
    callback = function()
      vim.cmd [[set filetype=conf]]
    end,
  })

  -- If a file is too large, I don't want to add to it's cmp sources treesitter, see:
  -- https://github.com/hrsh7th/nvim-cmp/issues/1522
  -- autocmd('BufReadPre', {
  --   callback = function(t)
  --     local cmp = require 'cmp'
  --     local sources = require('cmp').config.sources()
  --     if not Utils.bufIsBig(t.buf) then
  --       sources[#sources + 1] = { name = 'treesitter', group_index = 2 }
  --     end
  --     cmp.setup.buffer { soures = sources }
  --   end,
  -- })
  autocmd('FileType', {
    pattern = { 'sql', 'mysql', 'plsql' },
    callback = function()
      local cmp = require 'cmp'
      local sources = require('cmp').config.sources

      cmp.setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
    end,
  })

  -- Check if we need to reload the file when it changed
  autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = Utils.augroup 'checktime',
    command = 'checktime',
  })

  -- load barbecue
  autocmd('BufReadPost', {
    group = Utils.augroup 'barbecue',
    once = true,
    callback = function()
      autocmd({
        'WinScrolled',
        'WinResized',
        'BufWinEnter',
        'CursorHold',
        'InsertLeave',
        'BufModifiedSet',
      }, {
        group = vim.api.nvim_create_augroup('barbecue.updater', {}),
        callback = function()
          require('barbecue.ui').update()
        end,
      })
    end,
  })

  -- use q to close RO buffers
  autocmd('FileType', {
    group = Utils.augroup 'close_with_q',
    pattern = {
      'PlenaryTestPopup',
      'help',
      'lspinfo',
      'man',
      'notify',
      'qf',
      'spectre_panel',
      'startuptime',
      'tsplayground',
      'neotest-output',
      'checkhealth',
      'neotest-summary',
      'neotest-output-panel',
      'dbout',
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set(
        'n',
        'q',
        '<cmd>close<cr>',
        { buffer = event.buf, silent = true }
      )
    end,
  })

  autocmd('BufWinEnter', {
    pattern = { '*' },
    callback = function()
      vim.opt.formatoptions:append { c = false, r = false, o = false }
    end,
  })

  -- autocmd('BufWritePre', {
  --   pattern = { '*.ts', '*js', '*.tsx', '*jsx' },
  --   command = '<cmd>TypescriptOrganizeImports<cr>',
  -- })
  -- Auto create dir when saving a file, in case some intermediate directory does not exist
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
end, 10)
