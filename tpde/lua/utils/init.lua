local M = {}

M.augroup = function(name)
  return vim.api.nvim_create_augroup('tpde_' .. name, { clear = true })
end

M.has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

M.opts = function(name)
  local plugin = require('lazy.core.config').plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require 'lazy.core.plugin'
  return Plugin.values(plugin, 'opts', false)
end

M.navic = function()
  if package.loaded['nvim-navic'] then
    local navic = require 'nvim-navic'
    local loc = navic.get_location()
    if loc and #loc > 0 then
      return '%#NavicSeparator# ' .. navic.get_location()
    else
      return ''
    end
  else
    return ''
  end
end

return M
