local map = vim.keymap.set
local utils = require 'core.utils'
local M = {}

local config = {
  virtual_text = false,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
  signs = true,
}

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

--- Helper function to check if any active LSP clients given a filter provide a specific capability
---@param capability string The server capability to check for (example: "documentFormattingProvider")
---@param filter vim.lsp.get_active_clients.filter|nil (table|nil) A table with
---              key-value pairs used to filter the returned clients.
---              The available keys are:
---               - id (number): Only return clients with the given id
---               - bufnr (number): Only return clients attached to this buffer
---               - name (string): Only return clients with the given name
---@return boolean # Whether or not any of the clients provide the capability
M.has_capability = function(capability, filter)
  for _, client in ipairs(vim.lsp.get_active_clients(filter)) do
    if client.supports_method(capability) then
      return true
    end
  end
  return false
end

local keymaps = function(client, buffer)
  local telescope_builtin = require 'telescope.builtin'

  if client.supports_method 'textDocument/definition' then
    map('n', 'gd', vim.lsp.buf.definition, { desc = '[g]oto [d]efinition', buffer = buffer })
  end
  -- stylua: ignore
  map('n', 'gr', function() require('trouble').open 'lsp_references' end,
    { desc = '[g]oto [r]eferences', buffer = buffer })
  if client.supports_method 'textDocument/hover' then
    map('n', 'K', vim.lsp.buf.hover, { desc = 'hover' })
  end
  map('n', 'gi', vim.lsp.buf.implementation, { desc = '[g]oto [i]mplementation', buffer = buffer })
  -- stylua: ignore
  map('n', 'gl', vim.diagnostic.open_float, { desc = 'show [l]ine [d]iagnostics' })
  map('n', 'gK', vim.lsp.buf.signature_help, { desc = 'signature help', buffer = buffer })
  map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
  map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
  map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
  map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
  map('n', ']w', diagnostic_goto(true, 'WARNING'), { desc = 'Next Warning' })
  map('n', '[w', diagnostic_goto(false, 'WARNING'), { desc = 'Prev Warning' })
  if client.supports_method 'textDocument/codeAction' then
    map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[c]ode [a]ction' })
  end
  -- stylua: ignore
  map('n', '<leader>cw', telescope_builtin.lsp_dynamic_workspace_symbols,
    { desc = '[c]ode [w]orkspace symbols', buffer = buffer })
  if client.supports_method 'textDocument/rename' then
    map('n', '<leader>cr', vim.lsp.buf.rename, { desc = '[c]ode [r]ename', buffer = buffer })
  end
  -- map('n', '<space>cf', function() vim.lsp.buf.format { async = true } end, { desc = 'format buffer', buffer = buffer })
  if client.supports_method 'textDocument/codeLens' then
    utils.add_buffer_autocmd('lsp_codelens', buffer, {
      events = { 'InsertLeave', 'BufEnter' },
      desc = 'Refresh coedlens',
      callback = function()
        if not M.has_capability('textDocument/codeLens', { bufnr = buffer }) then
          utils.del_buffer_autocmd('lsp_codelens', buffer)
          return
        end
        if vim.g.codelens_enabled then
          vim.lsp.codelens.refresh()
        end
      end,
    })
    if vim.g.codelens_enabled then
      vim.lsp.codelens.refresh()
    end
    map('n', '<leader>cl', function()
      vim.lsp.codelens.refresh()
    end, { desc = 'lsp refresh codelens' })
    map('n', '<leader>la', function()
      vim.lsp.codelens.run()
    end, { desc = 'lsp codelens run' })
  end
end

-- local capabilities = function()
--   local capabilities = vim.lsp.protocol.make_client_capabilities()
--   capabilities.textDocument.completion.completionItem.snippetSupport = true
-- end
local capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

M.setup = function(_, opts)
  -- local client = {}
  vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
  utils.on_attach(function(client, bufnr)
    keymaps(client, bufnr)
  end)

  local servers = opts.servers
  local caps = utils.capabilities()

  -- if client.name ~= 'yamlls' then
  --   caps.textDocument.foldingRange = {
  --     dynamicRegistration = false,
  --     lineFoldingOnly = true,
  --   }
  -- end

  local function setup(server)
    local server_opts = vim.tbl_deep_extend('force', { capabilities = caps }, servers[server] or {})

    if opts.setup[server] then
      if opts.setup[server](server, server_opts) then
        return
      end
    elseif opts.setup['*'] then
      if opts.setup['*'](server, server_opts) then
        return
      end
    end
    require('lspconfig')[server].setup(server_opts)
  end

  local have_mason, mlsp = pcall(require, 'mason-lspconfig')
  local all_mslp_servers = {}
  if have_mason then
    all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
  end

  --@type string[]
  local ensure_installed = {}
  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false
      if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
        setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  if have_mason then
    mlsp.setup { ensure_installed = ensure_installed }
    mlsp.setup_handlers { setup }
  end
end

return M
