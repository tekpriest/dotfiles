-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- show lsp progress in the terminal
local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup('demo_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(ev)
    local value = ev.data.params.value or {}
    if not value.kind then return end

    local status = value.kind == 'end' and 0 or 1
    local percent = value.percentage or 0

    local osc_seq = string.format('\27]9;4;%d;%d\a', status, percent)

    if os.getenv 'TMUX' then
      osc_seq = string.format('\27Ptmux;\27%s\27\\', osc_seq)
    end

    io.stdout:write(osc_seq)
    io.stdout:flush()
  end,
})

-- close some filetypes with <q>
autocmd('FileType', {
  group = augroup 'close_more_with_q',
  pattern = {
    'Codi!!',
    'DressingInput',
    'OverseerForm',
    'OverseerList',
    'PlenaryTestPopup',
    'TelescopePrompt',
    'checkhealth',
    'dap-float',
    'floggraph',
    'fugitive',
    'git',
    'guihua',
    'help',
    'lspinfo',
    'man',
    'neoai-output',
    'neotest-output',
    'neotest-summary',
    'netrw',
    'notify',
    'qf',
    'query',
    'rest_nvim_results',
    'snacks_picker_input',
    'spectre_panel',
    'startuptime',
    'toggleterm',
    'tsplayground',
    'vim',
    'DressingSelect',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

autocmd({ 'CursorHold' }, {
  group = augroup 'show_diagnostics',
  callback = function(_, bufnr)
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then return end
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

vim.api.nvim_create_user_command(
  'TidyJson',
  function() vim.cmd [[%!jq 'walk(if type == "string" then "" else . end)']] end,
  {}
)

autocmd('VimEnter', {
  group = augroup 'transparent_status_line',
  callback = function()
    vim.cmd [[:hi StatusLine guibg=NONE]]
    vim.cmd [[:hi StatusLineNC guibg=NONE]]
    vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE', fg = 'NONE' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE', fg = 'NONE' })
  end,
})
