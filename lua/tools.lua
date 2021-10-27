local execute = vim.api.nvim_command
local vim = vim
local opt = vim.opt
local g = vim.g
local wo = vim.wo
local bo = vim.bo
local fn = vim.fn
local cmd = vim.cmd
local api = vim.api

function _G.preserve(cmd)
  cmd = string.format('keepjumps keeppatterns execute %q',cmd)
  local original_cursor = fn.winsaveview()
  vim.api.nvim_command(cmd)
  fn.winrestview(original_cursor)
end

local M = {}

M.delete_blank_lines = function()
  if (bo.filetype ~= 'binary') or (bo.filetype ~= 'diff') then
      preserve('sil! keepp keepj %s/^\\n\\{2,}/\\r/ge')
      preserve('sil! keepp keepj %s/\\v($\\n\\s*)+%$/\\r/e')
    end
end

M.changeheader = function ()
  if (fn.line('$') >= 7) then
    local time = os.date('%a, %d %b %Y %H:%M')
    preserve('sil! keepp keepj 1,7s/\\vlast (modified|change):\\zs.*/ ' .. time .. '/ei')
  end
end

return M
