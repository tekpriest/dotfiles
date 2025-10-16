local utils = require 'heirline.utils'
local conditions = require 'heirline.conditions'

local M = {}

M.init = function(self)
  self.filename = vim.api.nvim_buf_get_name(0)
end

M.Icon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color =
      require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. ' ')
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

M.Name = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ':.')
    if filename == '' then
      return ' '
    end
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
  hl = { fg = utils.get_highlight('Directory').fg },
  flexible = 2,
}

M.Flags =
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = ' ',
    hl = { fg = 'gray' },
  }, {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = ' ',
    hl = { fg = 'orange' },
  }

M.Type = {
  provider = function()
    return vim.bo.filetype
  end,
  hl = { fg = utils.get_highlight('Type').fg },
}

M.Encoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
    return enc ~= 'utf-8' and enc:upper()
  end,
}

M.Format = {
  provider = function()
    local fmt = vim.bo.fileformat
    return fmt ~= 'unix' and fmt:upper()
  end,
}

M.Size = {
  provider = function()
    -- stackoverflow, compute human readable file size
    local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
    fsize = (fsize < 0 and 0) or fsize
    if fsize < 1024 then
      return fsize .. suffix[1]
    end
    local i = math.floor((math.log(fsize) / math.log(1024)))
    return string.format('%.2g%s', fsize / math.pow(1024, i), suffix[i + 1])
  end,
}

M.LastModified = {
  provider = function()
    local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
    return (ftime > 0) and os.date('%c', ftime)
  end,
}

M.Directory = {
  condition = function(self)
    if vim.bo.buftype == '' then
      return self.pwd
    end
  end,
  init = function(self)
    self.icon = ' ' .. ' '
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ':~')
  end,
  hl = { fg = '#54546D' },

  flexible = 25,
  -- {
  --   provider = function(self)
  --     return self.pwd
  --   end,
  -- },
  -- {
  --   provider = function(self)
  --     return fn.pathshorten(self.pwd)
  --   end,
  -- },
  {
    -- evaluates to the full-lenth path
    provider = function(self)
      local trail = self.cwd:sub(-1) == '/' and '' or '/'
      return self.icon .. self.cwd .. trail .. ' '
    end,
  },
  {
    -- evaluates to the shortened path
    provider = function(self)
      local cwd = vim.fn.pathshorten(self.cwd)
      local trail = self.cwd:sub(-1) == '/' and '' or '/'
      return self.icon .. cwd .. trail .. ' '
    end,
  },
  {
    -- evaluates to "", hiding the component
    provider = '',
  },
}

M.provider = '%<'

return M
