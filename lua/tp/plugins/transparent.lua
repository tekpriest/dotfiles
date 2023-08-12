-- cspell:words xiyaowong octo
return {
  {
    'xiyaowong/transparent.nvim',
    config = function()
      vim.opt.signcolumn = 'yes'
      require('transparent').setup {
        extra_groups = {
          'NormalFloat', -- plugins which have float panel such as Lazy, Mason, LspInfo
          'FidgetTask',
        },
      }
    end,
  },
}
