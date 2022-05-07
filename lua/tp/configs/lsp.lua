local lsp = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")
local installed_servers = require("nvim-lsp-installer.servers")
local status = require("lsp-status")
local null = require("null-ls")

-- register status progress
status.register_progress()

-- diagnostic signs
local signs = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = nil,
  })
end

-- diagnostic
vim.diagnostic.config({
  virtual_text = false,
  signs = { active = true },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", focusable = false })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local on_attach = function(client, bufnr)
  status.on_attach(client)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- use lsp as the handler for formatexpr
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  -- configure key mappings
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "td", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gla", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "[d",
    '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded", severity = vim.diagnostic.severity.ERROR })<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "]d",
    '<cmd>lua vim.diagnostic.goto_next({ border = "rounded", severity = vim.diagnostic.severity.ERROR })<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>p", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting_sync()' ]])
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
  -- code highlight
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_command("autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()")
    vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
    vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()")
  end
  if client.resolved_capabilities.code_lens then
    vim.api.nvim_command("autocmd BufEnter,CursorHold,InsertLeave, <buffer> lua vim.lsp.codelens.refresh()")
  end
end
-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_lsp.update_capabilities(capabilities)
capabilities = vim.tbl_extend("keep", capabilities or {}, status.capabilities)

local servers = {
  gopls = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  tsserver = {},
  sumneko_lua = {
    -- on_attach = function(client, bufnr)
    -- 	client.resolved_capabilities.document_formatting = false
    -- 	client.resolved_capabilities.document_range_formatting = false
    -- end,
    on_attach = on_attach,
    capabilities = capabilities,
  },
  jsonls = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  zls = {
    -- on_attach = function(client, bufnr)
    -- 	client.resolved_capabilities.document_formatting = false
    -- 	client.resolved_capabilities.document_range_formatting = false
    -- end,
    on_attach = on_attach,
    capabilities = capabilities,
  },
  prismals = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  cmake = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
}

lsp.cmake.setup(servers.cmake)
lsp.zls.setup(servers.zls)
lsp.sumneko_lua.setup(servers.sumneko_lua)
lsp.tsserver.setup(servers.tsserver)
lsp.gopls.setup(servers.gopls)
lsp.jsonls.setup(servers.jsonls)

local lsp_servers = {
  clangd = {}
}

for name, _ in pairs(lsp_servers) do
  local options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }
  local available, server = installed_servers.get_server(name)

  if available then
    server:on_ready(function()
      local opts = vim.tbl_deep_extend("force", options, servers[name] or {})
      server:setup(opts)
    end)

    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

local b = null.builtins
null.setup({
  sources = {
    -- b.formatting.stylua,
    -- b.formatting.zigfmt,
    --b.formatting.prettier,
  },
  on_attach = on_attach,
  capabilities = capabilities,
})
