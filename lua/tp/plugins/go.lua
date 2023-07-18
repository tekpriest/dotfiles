return {
  'ray-x/go.nvim',
  ft = { 'go', 'gomod' },
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  build = ':lua require("go.install").update_all_sync()',
  event = { 'CmdlineEnter' },
  config = function()
    require('go').setup {
      icons = false,
      max_line_len = 100,
      lsp_gofumpt = true,
      lsp_diag_underline = false,
      lsp_inlay_hints = {
        enable = false,
        highlight = 'LSPInlayHint',
      },
      luasnip = true,
      comment_placeholder = ' ',
    }

    -- Run gofmt + goimport on save
    local format_sync_grp = vim.api.nvim_create_augroup('GoImport', {})
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.go',
      callback = function()
        require('go.format').goimport()
      end,
      group = format_sync_grp,
    })
  end,
}
