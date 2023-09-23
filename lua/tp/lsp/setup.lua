local M = {}

local ok_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok_cmp_nvim_lsp then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
  -- documentationFormat = { 'markdown', 'plaintext' },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  },
}
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}
M.setup = function()
  local config = {
    virtual_text = false,
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    signs = true,
  }
  vim.diagnostic.config(config)
end

local function keymaps(bufnr)
  local opts = { buffer = bufnr, remap = false }
  local map = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  local telescope_builtin = require 'telescope.builtin'

  vim.keymap.set('n', '[d', function()
    vim.diagnostic.goto_prev()
  end, opts)
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.goto_next()
  end, opts)

  map('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
  map('gD', vim.lsp.buf.declaration, '[g]oto [d]eclaration')
  map('K', vim.lsp.buf.hover, 'hover')
  map('gs', vim.lsp.buf.signature_help, 'show signature')
  map('gr', function()
    require('trouble').open 'lsp_references'
  end, '[g]oto [r]eferences')
  map('gl', vim.diagnostic.open_float, 'show [l]ine [d]iagnostics')
  map('gi', vim.lsp.buf.implementation, '[g]oto [i]mplementation')
  map('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')
  map('<leader>cf', vim.lsp.buf.format, '[c]ode [f]ormat')
  map('<leader>cr', vim.lsp.buf.rename, '[c]ode [r]ename')
  map('<leader>cs', telescope_builtin.lsp_document_symbols, '[c]ode [s]ymbols')
  map('<leader>cd', telescope_builtin.diagnostics, '[c]ode [d]ocument symbols')
  map('<leader>cw', telescope_builtin.lsp_dynamic_workspace_symbols, '[c]ode [w]orkspace symbols')
  map('<leader>cq', vim.diagnostic.setloclist, '[q]uickfix')
end

local setup_highlights = function(client, bufnr)
  if client.supports_method 'textDocument/documentHighlight' then
    vim.api.nvim_create_augroup('lsp_document_highlight', {
      clear = false,
    })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = 'lsp_document_highlight',
    }
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

M.on_attach = function(client, bufnr)
  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
  end
  if client.name == 'lua_ls' then
    client.server_capabilities.documentFormattingProvider = false
  end
  if client.name == 'clangd' then
    client.server_capabilities.signatureHelpProvider = false
  end
  if client.name == 'ruff_lsp' then
    client.server_capabilities.hoverProvider = false
  end
  keymaps(bufnr)
  setup_highlights(client, bufnr)

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { descc = 'Format current buffer' })
  end
end

return M
