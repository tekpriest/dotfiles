return {
  {
    'fgheng/winbar.nvim',
    config = function()
      require('winbar').setup {
        enabled = true,
        show_file_path = true,
        show_symbols = false,
        exclude_filetype = {
          'help',
          'startify',
          'dashboard',
          'packer',
          'neogitstatus',
          'NvimTree',
          'Trouble',
          'alpha',
          'lir',
          'Outline',
          'spectre_panel',
          'toggleterm',
          'qf',
          'lazygit',
        },
      }
    end,
  },
}
