return {
  {

    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      'tpope/vim-dadbod',
      {
        'kristijanhusak/vim-dadbod-completion',
        init = function()
          vim.g.completion_chain_complete_list = {
            sql = {
              { complete_items = { 'vim-dadbod-completion' } },
            },
          }
          vim.g.completion_matching_strategy_list = { 'exact', 'substring' }
          vim.g.completion_matching_ignore_case = 1
        end,
      },
    },
    event = 'VeryLazy',
    cmd = { 'DBUIToggle', 'DBUI', 'DBUIAddConnection' },
    keys = {
      { '<leader>dd', '<cmd>DBUIToggle<cr>', desc = 'toggle database ui' },
      {
        '<leader>da',
        '<cmd>DBUIAddConnection<cr>',
        desc = 'add database connection',
      },
    },
    init = function()
      vim.g = {
        db_ui_table_helpers = {
          Count = 'select count(*) from {table}',
        },
        db_ui_windwidth = 20,
      }
    end,
  },
}
