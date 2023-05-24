local M = {}

M.statusline = {
  theme = 'vscode_colored',
  overriden_modules = function()
    return {
      mode = function()
        return ''
      end,
    }
  end,
}

return M
