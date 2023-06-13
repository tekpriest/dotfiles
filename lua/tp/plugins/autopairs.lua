return {
  {
    'windwp/nvim-autopairs',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    opts = {
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
      },
      disable_filetype = { 'TelescopePrompt', 'vim' },
    },
    -- config = function(_, opts)
    --   require('nvim-autopairs').setup(opts)
    --
    --   -- setup cmp for autopairs
    --   local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    --   require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
    -- end,
  },
}
