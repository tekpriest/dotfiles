return {
  {
    'hashivim/vim-terraform',
    ft = { 'terraform' },
    config = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fmt_on_save = 1
      vim.g.terraform_fold_sections = 1
      vim.g.terraform_highlight_modified_values = 1
      vim.g.terraform_indent_on_bracket = 1
    end,
  },
}
