return {
  { 'nvim-lua/plenary.nvim' },
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    opts = {
      check_ts = true,
      ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
      },
      disable_filetype = { 'TelescopePrompt', 'vim' },
    },
    config = function(_, opts)
      require('nvim-autopairs').setup(opts)
      -- setup cmp for autopairs
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'wakatime/vim-wakatime',
    event = 'VeryLazy',
  },
  {
    'Shatur/neovim-session-manager',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    keys = {
      {
        '<leader>ql',
        '<cmd>SessionManager load_current_dir_session<cr>',
        desc = 'retore last session',
      },
    },
  },
  -- {
  --   '0oAstro/silicon.lua',
  --   opts = {
  --     font = 'Dank Mono',
  --     lineNumber = false,
  --     output = '/Users/tp/Pictures/snips/SILICON_${year}-${month}-${date}_${time}.png',
  --     gobble = true,
  --     shadowBlurRadius = 20,
  --   },
  --   keys = {
  --     {
  --       '<space>ss',
  --       function()
  --         require('silicon').visualise_api {}
  --       end,
  --       mode = { 'v', 'x' },
  --       desc = 'Take a silicon code snippet',
  --     },
  --     {
  --       '<space>sb',
  --       function()
  --         require('silicon').visualise_api { show_buf = true }
  --       end,
  --       mode = { 'n' },
  --       desc = 'Take a silicon code snippet into the clipboard',
  --     },
  --   },
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  -- },
  -- {
  --   '0oAstro/dim.lua',
  --   event = 'LspAttach',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'neovim/nvim-lspconfig' },
  --   opts = {
  --     disable_lsp_decorations = true,
  --   },
  -- },
  -- {
  --   'Shatur/neovim-session-manager',
  --   dependencies = {
  --     { 'nvim-lua/plenary.nvim' },
  --   },
  --   keys = {
  --     {
  --       '<leader>ql',
  --       '<cmd>SessionManager load_current_dir_session<cr>',
  --       desc = 'retore last session',
  --     },
  --   },
  -- },
  {
    'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    dependencies = { 'DaikyXendo/nvim-material-icon' },
    config = function()
      require('nvim-web-devicons').setup {
        override = require('nvim-material-icon').get_icons(),
      }
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  -- {
  --   'rcarriga/nvim-notify',
  --   opts = {
  --     background_colour = '#000000',
  --   },
  --   init = function()
  --     vim.notify = require 'notify'
  --   end,
  -- },
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    -- init = function()
    --   vim.cmd 'highlight! HarpoonInactive guibg=NONE guifg=#63698c'
    --   vim.cmd 'highlight! HarpoonActive guibg=NONE guifg=white'
    --   vim.cmd 'highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7'
    --   vim.cmd 'highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7'
    --   vim.cmd 'highlight! TabLineFill guibg=NONE guifg=white'
    -- end,
    keys = {
      {
        '<leader>ja',
        '<cmd>lua require("harpoon.mark").add_file()<cr>',
        desc = 'hook file',
      },
      {
        '<leader>jl',
        '<cmd>Telescope harpoon marks<cr>',
        desc = 'toggle harpoon menu',
      },
      {
        '<leader>jc',
        '<cmd>lua require("harpoon.mark").claer_all()<cr>',
        desc = 'clear harpoon menu',
      },
    },
  },
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup()
    end,
    cmd = { 'Refactor' },
    keys = {
      {
        '<leader>rx',
        function()
          require('refactoring').refactor 'Extract Function'
        end,
        desc = 'Extract Function',
        mode = { 'x' },
      },
      {
        '<leader>rf',
        function()
          require('refactoring').refactor 'Extract Function To File'
        end,
        desc = 'Extract Function To File',
        mode = { 'x' },
      },
      {
        '<leader>rv',
        function()
          require('refactoring').refactor 'Extract Variable'
        end,
        desc = 'Extract Variable',
        mode = { 'x' },
      },
      {
        '<leader>rI',
        function()
          require('refactoring').refactor 'Inline Function'
        end,
        desc = 'Inline Function',
      },
      {
        '<leader>ri',
        function()
          require('refactoring').refactor 'Inline Variable'
        end,
        desc = 'Inline Variable',
        mode = { 'n', 'x' },
      },
      {
        '<leader>rb',
        function()
          require('refactoring').refactor 'Extract Block'
        end,
        desc = 'Extract Block',
      },
      {
        '<leader>rbf',
        function()
          require('refactoring').refactor 'Extract Block To File'
        end,
        desc = 'Extract Block To File',
      },
    },
  },
  {
    'norcalli/nvim-colorizer.lua',
    -- event = 'VeryLazy',
    ft = { 'css', 'html', 'scss', 'typescriptreact', 'javascriptreact' },
    config = function()
      require('colorizer').setup({ 'css', 'scss', 'html', 'javascriptreact', 'typescriptreact' }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  { 'ellisonleao/glow.nvim', cmd = 'Glow', ft = { 'markdown' } },
  {
    'folke/twilight.nvim',
    cmd = { 'Twilight', 'TwilightEnable', 'TwilightDisable' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { '<leader>tt', '<cmd>Twilight<CR>', 'toggle twilight' },
    },
  },
  {
    'andymass/vim-matchup',
    event = { 'BufReadPost' },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
}
