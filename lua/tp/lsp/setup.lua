local M = {}

local ok_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok_cmp_nvim_lsp then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { 'markdown', 'plaintext' },
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
M.capabilities.workspace.configuration = true
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
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }
  vim.diagnostic.config(config)
  vim.lsp.handlers['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
    })
  vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'none',
    })
  vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = false,
      virtual_text = false,
      signs = false,
      update_in_insert = true,
    })
end

local function keymaps(bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition()
  end, opts)
  vim.keymap.set('n', 'K', function()
    if vim.bo.filetype == 'help' then
      vim.api.nvim_feedkeys('<c-]>', 'n', true)
    else
      vim.lsp.buf.hover()
    end
  end, opts)
  vim.keymap.set('n', '[d', function()
    vim.diagnostic.goto_prev()
  end, opts)
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.goto_next()
  end, opts)
  -- vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
  vim.keymap.set('n', '<leader>rn', function()
    vim.lsp.buf.rename()
  end, opts)
  vim.keymap.set('n', 'gs', function()
    vim.lsp.buf.signature_help()
  end, opts)
  vim.keymap.set('n', 'gl', function()
    vim.diagnostic.open_float()
  end, opts)
  vim.keymap.set('n', 'gi', function()
    vim.lsp.buf.implementation()
  end, opts)
  vim.keymap.set('n', '<leader>ca', function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set('n', '<leader>cf', function()
    vim.lsp.buf.format()
  end, opts)
  vim.keymap.set('n', '<leader>cr', function()
    vim.lsp.buf.rename()
  end, opts)
  vim.keymap.set(
    'n',
    '<leader>cs',
    '<cmd>Telescope lsp_document_symbols<cr>',
    opts
  )
  vim.keymap.set('n', '<leader>cd', '<cmd>Telescope diagnostics<cr>', opts)
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
end

return M
