return {
  {
    'nanozuki/tabby.nvim',
    init = function()
      vim.opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'
    end,
    opts = {
      presets = 'active_tab_with_wins',
      nerdfont = true,
    },
    keys = {
      { '<leader><Tab><Tab>', [[:$tabnew<CR>]], desc = 'New Tab' },
      { '<leader><Tab>d', [[:$tabclose<CR>]], desc = 'Close Tab' },
      { '<leader><Tab>o', [[:tabonly<CR>]], desc = 'Only Tab' },
      { '<leader><Tab>w', [[<cmd>Tabby pick_window<CR>]], desc = 'Pick window' },
      { '<leader><Tab>j', [[<cmd>Tabby jump_to_tab<CR>]], desc = 'Pick Tab' },
    },
  },
  { 'tiagovla/scope.nvim', config = true },
}
