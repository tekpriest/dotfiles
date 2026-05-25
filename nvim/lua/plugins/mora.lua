return {
  init = function() vim.filetype.add { extension = { mora = 'mora' } } end,
  'nvim-treesitter/nvim-treesitter',
  -- opts = function(_, opts)
  --   require('nvim-treesitter.parsers').mora = {
  --     install_info = {
  --       -- path = '~/Code/tree-sitter-mora',
  --       url = vim.fn.expand '~/Code/tree-sitter-mora',
  --       files = { 'src/parser.c' },
  --       generate_requires_npm = false,
  --       requires_generate_from_grammar = false,
  --     },
  --     filetype = 'mora',
  --   }
  --   table.insert(opts.ensure_installed, 'mora')
  -- end,
}
