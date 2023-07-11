return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  version = '*',
  cmd = 'Barbecue',
  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons', -- optional dependency
  },
  opts = {
    create_autocmd = false,
    show_modified = true,
    exclude_filetypes = { 'netrw', 'toggleterm', 'NeogitCommitMessage' },
    custom_section = function()
      -- Copied from @akinsho's config
      local error_icon = '✗' -- '✗'
      local warning_icon = ''
      local info_icon = '' --  
      local hint_icon = '' --  ⚑
      local errors =
        #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      local warnings =
        #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      local hints =
        #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      local info =
        #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      local components = {}
      if errors > 0 then
        components[#components + 1] =
          { error_icon .. ' ' .. errors, 'DiagnosticError' }
      end

      if warnings > 0 then
        components[#components + 1] = {
          (#components > 0 and ' ' or '') .. warning_icon .. ' ' .. warnings,
          'DiagnosticWarning',
        }
      end

      if hints > 0 then
        components[#components + 1] = {
          (#components > 0 and ' ' or '') .. hint_icon .. ' ' .. hints,
          'DiagnosticHint',
        }
      end

      if info > 0 then
        components[#components + 1] = {
          (#components > 0 and ' ' or '') .. info_icon .. ' ' .. info,
          'DiagnosticInfo',
        }
      end

      return components
    end,
  },
}
