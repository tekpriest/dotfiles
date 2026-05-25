return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    optional = true,
    ft = function(_, ft) vim.list_extend(ft, { 'livebook' }) end,
  },
}
