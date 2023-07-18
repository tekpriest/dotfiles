vim.defer_fn(function()
  local api = vim.api
  local autocmd = api.nvim_create_autocmd
  local Utils = require 'tp.utils'
  local misc_aucmd =
    vim.api.nvim_create_augroup('misc_aucmds', { clear = true })

  -- auto resize when resizing nvim window
  autocmd('VimResized', {
    pattern = '*',
    command = 'tabdo wincmd =',
  })

  local highlight_group =
    vim.api.nvim_create_augroup('YankHighlight', { clear = true })
  autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank { higroup = 'Visual', timeout = 100 }
    end,
    group = highlight_group,
    pattern = '*',
  })

  -- set cursor to the last position when opening a buffer
  autocmd('BufReadPost', {
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
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
  autocmd({ 'BufNewFile', 'BufFilePre', 'BufRead' }, {
    pattern = { '*.mdx', '*.md' },
    callback = function()
      vim.cmd [[set filetype=markdown wrap linebreak nolist nospell]]
    end,
  })

  -- set .conf files to sh
  autocmd({ 'BufRead' }, {
    pattern = { '*.conf' },
    callback = function()
      vim.cmd [[set filetype=sh]]
    end,
  })

  -- If a file is too large, I don't want to add to it's cmp sources treesitter, see:
  -- https://github.com/hrsh7th/nvim-cmp/issues/1522
  autocmd('BufReadPre', {
    callback = function(t)
      local cmp = require 'cmp'
      local sources = require('cmp').config.sources()
      if not Utils.bufIsBig(t.buf) then
        sources[#sources + 1] = { name = 'treesitter', group_index = 2 }
      end
      cmp.setup.buffer { soures = sources }
    end,
  })

  -- autoreload file on focus
  autocmd('BufWinEnter', { group = misc_aucmd, command = 'checktime' })

  -- set no buf listed
  autocmd('FileType', {
    group = misc_aucmd,
    pattern = { 'qf' },
    command = 'set nobuflisted',
  })

  -- load barbecue
  autocmd('BufReadPost', {
    group = misc_aucmd,
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

  -- diff orig
  vim.api.nvim_create_user_command('DiffOrig', function()
    -- get start buffer
    local start = vim.api.nvim_get_current_buf()

    -- `vnew` - Create empty vertical split window
    -- `set buftype=nofile` - Buffer is not related to a file, will not be written
    -- `0d_` - Remove an empty start row
    -- `diffthis` - Set diff mode to a new vertial split
    vim.cmd [[vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis ]]

    -- get scratch buffer
    local scratch = vim.api.nvim_get_current_buf()

    -- `wincmd p` - Go to the start window
    -- `diffthis` - Set diff mode to a start window
    vim.cmd [[wincmd p | diffthis]]

    -- Map `q` for both buffers to exit diff view and delete scratch buffer
    for _, buf in ipairs { scratch, start } do
      vim.keymap.set('n', 'q', function()
        vim.api.nvim_buf_delete(scratch, { force = true })
        vim.keymap.del('n', 'q', { buffer = start })
      end, { buffer = start })
    end
  end, {})

  -- use q to close RO buffers
  vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
  augroup end]]

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
end, 10)
