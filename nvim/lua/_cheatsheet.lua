local toggle_term_ok, toggleterm = pcall(require, 'toggleterm')
if not toggle_term_ok then
  return
end

local M = {}

local Terminal = require('toggleterm.terminal').Terminal
local lang = ''
local file_type = ''

local default_on_open = function(term)
  vim.cmd 'stopinsert'
  vim.api.nvim_buf_set_keymap(
    term.bufnr,
    'n',
    'q',
    '<cmd>close<CR>',
    { noremap = true, silent = true }
  )
end

local cheatsheet_on_open = function(term)
  vim.cmd 'stopinsert'
  vim.api.nvim_buf_set_keymap(
    term.bufnr,
    'n',
    'q',
    '<cmd>close<CR>',
    { noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_name(term.bufnr, 'cheatsheet-' .. term.bufnr)
  vim.api.nvim_buf_set_option(term.bufnr, 'filetype', 'cheat')
  vim.api.nvim_buf_set_option(term.bufnr, 'syntax', lang)
end

local function cheatsheet_on_exit(_)
  vim.cmd [[normal gg]]
end

M.open_term = function(cmd, opts)
  opts = opts or {}
  opts.size = opts.size or vim.o.columns * 0.5
  opts.direction = opts.direction or 'float'
  opts.on_open = opts.on_open or default_on_open
  opts.on_exit = opts.on_exit or nil

  local term = Terminal:new {
    cmd = cmd,
    dir = 'git_dir',
    auto_scroll = false,
    close_on_exit = false,
    start_in_insert = false,
    on_open = opts.on_open,
    on_exit = opts.on_exit,
  }
  term:open(opts.size, opts.direction)
end

M.cheatsheet = function()
  local buf = vim.api.nvim_get_current_buf()
  lang = ''
  file_type = vim.api.nvim_buf_get_option(buf, 'filetype')
  vim.ui.input({ prompt = 'cht.sh', default = ' ' }, function(input)
    local cmd = ''
    if input == '' or not input then
      return
    elseif input == 'h' then
      cmd = ''
    else
      local search = ''
      local delimiter = ' '
      for w in (input .. delimiter):gmatch('(.-)' .. delimiter) do
        if lang == '' then
          lang = w
        else
          if search == '' then
            search = w
          else
            search = search .. '+' .. w
          end
        end
      end
      cmd = lang
      if search ~= '' then
        cmd = cmd .. '/' .. search
      end
    end
    cmd = 'curl cht.sh/' .. cmd
    M.open_term(
      cmd,
      { direction = 'vertical', on_open = cheatsheet_on_open, on_exit = cheatsheet_on_exit }
    )
  end)
end

M.stack_overflow = function()
  local buf = vim.api.nvim_get_current_buf()
  file_type = vim.api.nvim_buf_get_option(buf, 'filetype')
  vim.ui.input({ prompt = 'so', default = ' ' }, function(input)
    local cmd = ''
    if input == '' or not input then
      return
    elseif input == 'h' then
      cmd = '-h'
    else
      cmd = input
    end
    cmd = 'so ' .. cmd
    M.open_term(cmd, { direction = 'float' })
  end)
end

return M
