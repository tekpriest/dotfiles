return {
  -- better ui
  {
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.input(...)
      end
    end,
  },

  -- bufferline
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require('tp.core').icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
            .. (diag.warning and icons.Warn .. diag.warning or '')
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
  },

  -- indent guides for Neovim
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPost',
    opts = {
      -- char = "▏",
      char = '│',
      filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy' },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  -- dashboard
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    opts = function()
      local dashboard = require 'alpha.themes.dashboard'

      -- dashboard.section.header.val = vim.split(logo, '\n')
      dashboard.section.buttons.val = {
        dashboard.button('f', ' ' .. ' Find file', ':Telescope find_files <CR>'),
        dashboard.button('n', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button('g', ' ' .. ' Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', ' ' .. ' Config', ':e $MYVIMRC <CR>'),
        dashboard.button(
          's',
          '勒' .. ' Restore Session',
          [[:lua require("persistence").load() <cr>]]
        ),
        dashboard.button('l', '鈴' .. ' Lazy', ':Lazy<CR>'),
        dashboard.button('q', ' ' .. ' Quit', ':qa<CR>'),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = 'AlphaButtons'
        button.opts.hl_shortcut = 'AlphaShortcut'
      end
      dashboard.section.footer.opts.hl = 'Type'
      dashboard.section.header.opts.hl = 'AlphaHeader'
      dashboard.section.buttons.opts.hl = 'AlphaButtons'
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      vim.b.miniindentscope_disable = true

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'AlphaReady',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      require('alpha').setup(dashboard.opts)

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = '⚡ Neovim loaded '
            .. stats.count
            .. ' plugins in '
            .. ms
            .. 'ms'
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- lsp symbol navigation for lualine
  {
    'SmiteshP/nvim-navic',
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require('tp.core._util').on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = ' ',
        highlight = true,
        depth_limit = 5,
        icons = require('tp.core').icons.kinds,
      }
    end,
  },

  -- icons
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- ui components
  { 'MunifTanjim/nui.nvim', lazy = true },
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    opts = {
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    },
    keys = {
      { '<leader>tt', '<cmd>ToggleTerm<CR>', desc = 'Toggle Term' },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand '%=t') ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand '%=p=h'
          local gitdir = vim.fn.finddir('.git', filepath .. ';')
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }
      local lualine = require 'lualine'
      -- local colors = require 'kanagawa.colors'

      -- local function modified()
      --   if vim.bo.modified then
      --     return ' ●'
      --   elseif vim.bo.modifiable == false or vim.bo.readonly == true then
      --     return '#'
      --   end
      --   return ''
      -- end

      lualine.setup {
        options = {
          disabled_filetypes = { 'NvimTree', 'dashboard', 'Outline' },
          icons_enabled = true,
          component_separators = { ' ', ' ' },
          -- component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            {
              function()
                return ''
              end,
            },
            { 'filesize', cond = conditions.buffer_not_empty },
          },
          lualine_b = {
            { 'branch', icon = '', gui = 'bold' },
            {
              'diff',
              symbols = { added = ' ', modified = '柳', removed = ' ' },
              diff_color = {
                added = { fg = '#a7c080' },
                modified = { fg = '#ffdf1b' },
                removed = { fg = '#ff6666' },
              },
            },
          },
          lualine_c = {
            --   {
            --     'diagnostics',
            --     sources = { 'nvim_diagnostic' },
            --     symbols = {
            --       error = ' ',
            --       warn = ' ',
            --       info = ' ',
            --       hint = ' ',
            --     },
            --   },
            '%=',
            {
              'filename',
              path = 1,
              file_status = false,
              cond = conditions.buffer_not_empty,
              color = { fg = '#333333', bg = '#eeeeee' },
              separator = { left = '', right = '' },
            },
            --   -- {
            --   --   modified,
            --   --   color = { fg = colors.red },
            --   -- },
          },
          lualine_x = {
            { 'filetype', cond = conditions.buffer_not_empty },
          },
          -- lualine_y = {
          --   { 'location' },
          -- },
          lualine_z = {
            -- { 'progress' },
            {
              function()
                local msg = ''
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                  return msg
                end
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    -- return client.name
                    return ' 綠'
                  end
                end
                return msg
              end,
              -- icon = ' 綠',
              color = { gui = 'bold' },
            },
            { "os.date('%a')", color = { gui = 'bold' } },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          -- lualine_z = {},
        },
        tabline = {},
        extensions = {
          'quickfix',
        },
      }
    end,
  },
  {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup {
        debounce_threshold = { falling = 500, rising = 250 },
        render = function(props)
          local incl = {}
          local bufname = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(bufname, ':t')
          local modified = vim.api.nvim_buf_get_option(props.buf, 'modified') and 'bold,italic'
            or 'None'
          local filetype_icon, color = require('nvim-web-devicons').get_icon_color(filename)

          local buffer = {
            { filetype_icon, guifg = color },
            { ' ' },
            { filename, gui = modified },
          }
          local diagnostics = function()
            local icons = {
              Error = '',
              Warn = '',
              Info = '',
              Hint = '',
            }

            local label = {}
            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(
                props.buf,
                { severity = vim.diagnostic.severity[string.upper(severity)] }
              )
              if n > 0 then
                table.insert(
                  label,
                  { icon .. ' ' .. n .. ' ', group = 'DiagnosticSign' .. severity }
                )
              end
            end
            return label
          end

          if #diagnostics() > 0 then
            table.insert(incl, diagnostics())
            -- table.insert(incl, { '| ', guifg = 'grey' })
          end
          -- for _, buffer_ in ipairs(buffer) do
          --   table.insert(incl, buffer_)
          -- end
          return incl
        end,
      }
    end,
  },
  -- {
  --   'folke/noice.nvim',
  --   dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
  --   opts = {
  --     cmdline = { view = 'cmdline' },
  --   },
  -- },
}
