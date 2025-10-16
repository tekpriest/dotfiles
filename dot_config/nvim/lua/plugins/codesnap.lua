return {
  'mistricky/codesnap.nvim',
  build = 'make',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>Cc',
      '<cmd>CodeSnap<cr>',
      mode = 'x',
      desc = 'Save selected code snapshot into clipboard',
    },
    {
      '<leader>Cs',
      '<cmd>CodeSnapSave<cr>',
      mode = 'x',
      desc = 'Save selected code snapshot in ~/Pictures',
    },
  },
  opts = {
    save_path = '~/Pictures',
    bg_theme = 'grape',
    watermark = '',
    title = '',
    code_font_family = 'DankMono Nerd Font Mono',
    has_breadcrumbs = true,
    show_workspace = true,
    breadcrumbs_separator = '>',
    has_line_number = true,
  },
}
