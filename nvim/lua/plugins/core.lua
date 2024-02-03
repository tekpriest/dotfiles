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
      map_cr = false,
    },
    config = function(_, opts)
      require('nvim-autopairs').setup(opts)
      -- setup cmp for autopairs
      -- local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      -- require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'wakatime/vim-wakatime',
    event = 'VeryLazy',
  },
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
  {
    'rcarriga/nvim-notify',
    opts = {
      background_colour = '#000000',
    },
    init = function()
      vim.notify = require 'notify'
    end,
  },
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
