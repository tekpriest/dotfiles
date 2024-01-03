return {
  {
    'rebelot/heirline.nvim',
    init = function()
      vim.cmd [[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]]
      vim.o.showmode = false
    end,
    config = function()
      local conditions = require 'heirline.conditions'
      local utils = require 'heirline.utils'

      local FileBlock = {
        init = function(self)
          self.filename = vim.api.nvim_buf_get_name(0)
        end,
      }

      local FileBlockComponents = {
        Icon = {
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
        },
        Name = {
          provider = function(self)
            local filename = vim.fn.fnamemodify(self.filename, ':.')
            if filename == '' then
              return '[Scratch]'
            end
            if not conditions.width_percent_below(#filename, 0.25) then
              filename = vim.fn.pathshorten(filename)
            end
            return filename
          end,
          hl = { fg = utils.get_highlight('Directory').fg },
          flexible = 2,
          {
            provider = function(self)
              return self.lfilename
            end,
          },
          {
            provider = function(self)
              return vim.fn.pathshorten(self.lfilename)
            end,
          },
        },
        Flags = {
          condition = function()
            return vim.bo.modified
          end,
          provider = '[+]',
          hl = { fg = 'gray' },
        },
        {
          condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = '',
          hl = { fg = 'orange' },
        },
        Type = {
          provider = function()
            return vim.bo.filetype
          end,
          hl = { fg = utils.get_highlight('Type').fg },
        },
        Encoding = {
          provider = function()
            local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
            return enc ~= 'utf-8' and enc:upper()
          end,
        },
        Format = {
          provider = function()
            local fmt = vim.bo.fileformat
            return fmt ~= 'unix' and fmt:upper()
          end,
        },
        Size = {
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
        },
        LastModified = {
          provider = function()
            local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
            return (ftime > 0) and os.date('%c', ftime)
          end,
        },
        Directory = {
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
        },
      }

      local LSP = {
        Active = {
          condition = conditions.lsp_attached,
          update = { 'LspAttach', 'LspDetach' },
          provider = function()
            local names = {}
            for _, server in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
              table.insert(names, server.name)
            end
            return '[' .. table.concat(names, ' ') .. ']'
          end,
          hl = { fg = '#938056' },
        },
      }

      local Align = { provider = '%=' }
      local Space = { provider = ' ' }

      FileBlock = utils.insert(
        FileBlock,
        FileBlockComponents.Directory,
        FileBlockComponents.Icon,
        FileBlockComponents.Name,
        FileBlockComponents.Flags,
        { provider = '%<' }
      )

      local StatusLine = {
        FileBlock,
        Space,
        Align,
        LSP.Active,
        Space,
        FileBlockComponents.Type,
        hl = { bg = 'none' },
      }

      require('heirline').setup {
        statusline = StatusLine,
        opts = {
          -- if the callback returns true, the winbar will be disabled for that window
          -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
          disable_winbar_cb = function(args)
            return conditions.buffer_matches({
              buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
              filetype = { '^git.*', 'fugitive', 'Trouble', 'dashboard' },
            }, args.buf)
          end,
        },
      }
    end,
  },
}
