return {
  {
    'hashivim/vim-terraform',
    ft = { 'terraform' },
    keys = {
      {
        '<leader>ti',
        '<cmd>Terraform init<cr>',
        desc = 'initialize terraform',
      },
      { '<leader>tp', '<cmd>Terraform plan<cr>', 'plan terraform' },
      { '<leader>ta', '<cmd>Terraform apply<cr>', 'apply terraform plan' },
      { '<leader>td', '<cmd>Terraform destroy<cr>', 'destroy terraform plan' },
    },
    init = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fmt_on_save = 1
      vim.g.terraform_fold_sections = 1
      vim.g.terraform_highlight_modified_values = 1
      vim.g.terraform_indent_on_bracket = 1
    end,
  },
}
