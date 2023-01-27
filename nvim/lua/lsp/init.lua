local borders = vim.g.FloatBorders

-- diagnostic signs
local signs = {
  Error = '',
  Warn = '',
  Hint = '',
  Info = '',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = nil,
  })
end

-- diagnostic
vim.diagnostic.config {
  virtual_text = { spacing = 4, prefix = '●' },
  signs = { active = true },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}
-----------------------
-- Handlers override --
-----------------------

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  silent = true,
  max_height = '10',
  border = 'rounded',
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/documentSymbol'] = vim.lsp.with(vim.lsp.handlers.document_symbol, {
  silent = true,
  border = 'rounded',
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lsp keymappings
local lsp_keymaps = function(bufnr)
  local opts = { noremap = true, silent = true }
  local map = vim.api.nvim_buf_set_keymap
  map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  map(bufnr, 'n', 'gla', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map(bufnr, 'n', 'gk', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  map(bufnr, 'n', 'gj', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  map(bufnr, 'n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  lsp_keymaps(bufnr)
  require('nvim-navic').attach(client, bufnr)

  if client.server_capabilities.documentFormattingProvider then
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
    vim.api.nvim_command 'autocmd BufWritePre <buffer> lua vim.lsp.buf.format()'
  end

  if client.server_capabilities.documentRangeFormattingProvider then
    vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr(#{timeout_ms:250})')
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
    vim.api.nvim_command 'autocmd BufWritePre <buffer> lua vim.lsp.buf.format()'
  end

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = 'lsp_document_highlight' }
    vim.api.nvim_create_autocmd('CursorHold', {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = 'lsp_document_highlight',
      desc = 'Document Highlight',
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = 'lsp_document_highlight',
      desc = 'Clear All the References',
    })
  end
  -- if client.server_capabilities.signatureHelpProvider then
  --     local lsp_signature_help_au_id = vim.api.nvim_create_augroup("LSP_signature_help", { clear = true })
  --     vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
  --         callback = function()
  --             vim.lsp.buf.signature_help({ focusable = false })
  --         end,
  --         group = lsp_signature_help_au_id,
  --         buffer = bufnr,
  --     })
end

local M = {}
M.default_on_attach = on_attach
M.default_capabilities = capabilities
M.borders = borders
return M
