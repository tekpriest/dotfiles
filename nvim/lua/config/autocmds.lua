-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local augroup = function(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('FileType', {
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
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  group = augroup 'highlight_linenr',
  pattern = { '*' },
  command = [[highlight CursorLineNr cterm=bold term=bold gui=bold]],
})
