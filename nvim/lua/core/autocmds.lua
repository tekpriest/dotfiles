local autocmd = vim.api.nvim_create_autocmd

local augroup = function(name)
  return vim.api.nvim_create_augroup('nvim_' .. name, { clear = true })
end

autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual', timeout = 100 }
  end,
  group = augroup 'highlight_yank',
  pattern = '*',
})

autocmd('BufReadPost', {
  group = augroup 'last_loc',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd('FileType', {
  group = augroup 'close_with_q',
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
    'rest_nvim_results',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

autocmd({ 'BufWinEnter' }, {
  group = augroup 'auto_format_options',
  callback = function()
    vim.cmd 'set formatoptions-=cro'
  end,
})

-- resize splits if window got resized
autocmd({ 'VimResized' }, {
  group = augroup 'resize_splits',
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

autocmd('FileType', {
  pattern = { 'templ' },
  command = vim.cmd [[setfiletype templ]],
})

-- Check if we need to reload the file when it changed
autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup 'checktime',
  command = 'checktime',
})

autocmd({ 'BufWritePre' }, {
  group = augroup 'auto_create_dir',
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
  group = augroup 'help_window_right',
  pattern = { '#.txt' },
  callback = function()
    if vim.o.filetype == 'help' then
      vim.cmd.wincmd 'L'
    end
  end,
})

autocmd({ 'CursorHold' }, {
  group = augroup 'show_diagnostics',
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
  group = augroup 'buf_check',
  pattern = { 'NeogitCommitMessage' },
  command = 'startinsert | 1',
})

autocmd({ 'BufNewFile', 'BufReadPost' }, {
  group = augroup 'set_eex_mjml',
  pattern = { '*.mjml' },
  command = [[set filetype=html]],
})

autocmd('ColorScheme', {
  pattern = { '*' },
  command = [[highlight CursorLineNr cterm=bold term=bold gui=bold]],
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'CocGroup',
  pattern = "typescript,json",
  command = [[setl formatexpr=CocAction('formatSelected')]],
  desc = "Setup formatexpr specified filetype(s)."
})

vim.api.nvim_create_autocmd("User", {
  group = "CocGroup",
  pattern = "CocJumpPlaceholder",
  command = [[call CocActionAsync('showSignatureHelp')]],
  desc = "Update signature help on jump placeholder"
})
