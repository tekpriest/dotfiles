return {
  {
    'metakirby5/codi.vim',
    init = function()
      -- vim.g["codi#virtual_text"] = "0"
    end,
    keys = {
      {
        '<leader>rs',
        '<cmd>CodiSelect<cr>',
        desc = 'toggle codi repl',
      },
    },
  },
}
