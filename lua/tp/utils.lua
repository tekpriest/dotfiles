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

M.on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition()
  end, opts)
  vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover()
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
  -- vim.keymap.set('n', '<leader>ca', function()
  --   vim.lsp.buf.code_action()
  -- end, opts)
  vim.keymap.set('n', 'gs', function()
    vim.lsp.buf.signature_help()
  end, opts)
  vim.keymap.set('n', 'gl', function()
    vim.diagnostic.open_float()
  end, opts)
  vim.keymap.set('n', 'gi', function()
    vim.lsp.buf.implementation()
  end, opts)
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

return M
