return {
  { 'b0o/SchemaStore.nvim', ft = { 'json', 'yaml' } },
  {
    'wakatime/vim-wakatime',
    event = 'VeryLazy',
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = {
      user_default_options = {
        mode = 'virtualtext',
      },
    },
  },
  {
    'm-demare/hlargs.nvim',
    opts = {},
  },
  {
    'nvim-tree/nvim-web-devicons',
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach',
    opts = {
      text = {
        spinner = 'dots_footsteps',
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    opts = {
      check_ts = true,
      ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
      },
      disable_filetype = { 'TelescopePrompt', 'vim' },
    },
    init = function()
      -- setup cmp for autopairs
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    cmd = 'Barbecue',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    opts = {
      create_autocmd = false,
      show_modified = true,
      exclude_filetypes = { 'netrw', 'toggleterm', 'NeogitCommitMessage' },
      custom_section = function()
        -- Copied from @akinsho's config
        -- local error_icon = '✗' -- '✗'
        -- local warning_icon = ''
        -- local info_icon = '' --  
        -- local hint_icon = '' --  ⚑
        local error_icon = 'E'
        local warning_icon = 'W'
        local info_icon = 'I'
        local hint_icon = 'H'
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
  },
  {
    'tpope/vim-sleuth',
  },
}
