-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
  return vim.api.nvim_create_augroup('tpde_' .. name, { clear = true })
end

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
    'DressingInput',
    'dap-float',
    'TelescopePrompt',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close!<cr>', { buffer = event.buf, silent = true })
  end,
})

autocmd({ 'BufWinEnter' }, {
  group = augroup 'auto_format_options',
  callback = function()
    vim.cmd 'set formatoptions-=cro'
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

-- autocmd({ 'BufWritePre' }, {
--   group = augroup 'auto_create_dir',
--   callback = function(event)
--     if event.match:match '^%w%w+://' then
--       return
--     end
--     local file = vim.loop.fs_realpath(event.match) or event.match
--     vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
--   end,
-- })

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

vim.api.nvim_create_user_command('ElixirToJson', function()
  vim.cmd [[%s/ =>/: /g]]
  vim.cmd [[%s/\<nil\>/null/g]]
end, {})

autocmd('FileType', {
  group = augroup 'set_yaml_template',
  pattern = { '*.yml.*' },
  command = [[setfiletype yaml]],
})

autocmd('VimEnter', {
  group = augroup 'transparent_status_line',
  callback = function()
    vim.cmd [[:hi StatusLine guibg=NONE]]
    vim.cmd [[:hi StatusLineNC guibg=NONE]]
    vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE', fg = 'NONE' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE', fg = 'NONE' })
  end,
})

vim.api.nvim_create_user_command('TidyJson', function()
  vim.cmd [[%!jq 'walk(if type == "string" then "" else . end)']]
end, {})
