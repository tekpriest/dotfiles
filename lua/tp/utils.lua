local M = {}

M.has_words_before = function()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api
        .nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
        :match '^%s*$'
      == nil
end

M.bufIsBig = function(bufnr)
  local max_filesize = 100 * 1024 -- 100 kbs
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  if ok and stats and stats.size > max_filesize then
    return true
  else
    return false
  end
end

-- TODO: possibly other implementation
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
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
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
    -- local ft = vim.bo[bufnr].filetype
    -- local have_nls = package.loaded['null-ls']
    --   and #require('null-ls.sources').get_available(ft, 'NULL_LS_FORMATTING')
    --     > 0
    vim.lsp.buf.format()

    -- vim.lsp.buf.format {
    --   filter = function()
    --     if have_nls then
    --       return client.name == 'null-ls'
    --     end
    --     return client.name ~= 'null-ls'
    --   end,
    -- }
  end, opts)
  vim.keymap.set('n', '<leader>cr', function()
    vim.lsp.buf.rename()
  end, opts)

  setup_highlights(client, bufnr)

  -- autoformat
  -- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
  -- if client.supports_method 'textDocument/formatting' then
  --   vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
  --   vim.api.nvim_create_autocmd('BufWritePre', {
  --     group = augroup,
  --     buffer = bufnr,
  --     callback = function()
  --       vim.lsp.buf.format { bufnr = bufnr }
  --     end,
  --   })
  -- end
end

M.print_diagnostics = function(opts, bufnr, line_nr, client_id)
  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
  opts = opts or { ['lnum'] = line_nr }

  local line_diagnostics = vim.diagnostic.get(bufnr, opts)
  if vim.tbl_isempty(line_diagnostics) then
    return
  end

  local diagnostic_message = ''
  for i, diagnostic in ipairs(line_diagnostics) do
    diagnostic_message = diagnostic_message
      .. string.format('%d: %s', i, diagnostic.message or '')
    print(diagnostic_message)
    if i ~= #line_diagnostics then
      diagnostic_message = diagnostic_message .. '\n'
    end
  end
  vim.api.nvim_echo({ { diagnostic_message, 'Normal' } }, false, {})
end

-- disagnostic signs
M.setup_diag_signs = function()
  local signs = {
    { name = 'DiagnosticSignError', text = '✖' },
    { name = 'DiagnosticSignWarn', text = '‼' },
    { name = 'DiagnosticSignHint', text = 'ℹ' },
    { name = 'DiagnosticSignInfo', text = '»' },
  }

  for _, sign in ipairs(signs) do
    local hl = sign.name
    local text = sign.text
    vim.fn.sign_define(hl, { text = text, texthl = hl, numhl = 'none' })
  end
end

M.border = {
  { '🭽', 'FloatBorder' },
  { '▔', 'FloatBorder' },
  { '🭾', 'FloatBorder' },
  { '▕', 'FloatBorder' },
  { '🭿', 'FloatBorder' },
  { '▁', 'FloatBorder' },
  { '🭼', 'FloatBorder' },
  { '▏', 'FloatBorder' },
}

M.capabilities = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = true,
    lineFoldingOnly = true,
  }

  return capabilities
end

M.check_backspace = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

return M
