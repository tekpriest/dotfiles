return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/nvim-cmp',
    'nvim-treesitter/nvim-treesitter',
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
}
