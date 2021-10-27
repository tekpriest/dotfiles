local vim = _G.vim
local api = vim.api

function _G.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup '..group_name)
    api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd',def}, ' ')
      api.nvim_command(command)
    end
    api.nvim_command('augroup END')
  end
end

local autocmds = {
  reload_config_files = {
    {"BufWritePost", "*.lua", ":luafile %"};
  };
  change_header = {
    {"BufWritePre", "*", "lua require('tools').changeheader()"};
  };
  del_blank_lines = {
    {"BufWritePre", "*", "lua require('tools').delete_blank_lines()"}
  };
  restore_cursor = {
    {'BufRead', '*', [[call setpos(".", getpos("'\""))]]};
  };
  save_shada = {
    {'VimLeave', '*', 'wshada!'};
  };
  resize_windows_horizontally = {
    {'VimResized', '*', ':wincmd ='};
  };
  toggle_search_highlighting = {
    { 'InsertEnter', '*', 'setlocal nohlsearch'};
  };
  lua_highlight = {
    { "TextYankPost", "*", [[silent! lua vim.highlight.on_yank() {higroup="IncSearch", timeout=400}]] };
  };
}

nvim_create_augroups(autocmds)
