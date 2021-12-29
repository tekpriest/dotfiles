local mapBuf = require("utils.set-key").setBufKey
local nvim_cmp = require("cmp_nvim_lsp")
local lsp = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = nvim_cmp.update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

local on_attach = function(client, bufnr)
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  mapBuf(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
  mapBuf(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
  mapBuf(bufnr, "n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  mapBuf(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover()<cr>")
  mapBuf(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  mapBuf(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  mapBuf(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>")
  mapBuf(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")

  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

local sumneko_path = os.getenv("HOME") .. "/.local/bin/lua-language-server"
local sumneko_bin = sumneko_path .. "/bin/macOS/lua-language-server"

-- Lua
lsp.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { sumneko_bin, "-E", sumneko_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      completion = {
        enable = true,
        callSnippet = "Both",
      },
      diagnostics = {
        enable = true,
        globals = { "vim" },
        disable = { "lowercase-global" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        maxPreload = 2000,
        preloadFileSize = 1000,
      },
    },
  },
})

-- Elixir
local elixir_lsp_loc = vim.fn.expand("~/.local/bin/elixir-ls/release/language_server.sh")
lsp.elixirls.setup({
  cmd = { elixir_lsp_loc },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
})

-- JS/TS
lsp.tsserver.setup({
  capabilities = nvim_cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({})
    ts_utils.setup_client(client)

    mapBuf(bufnr, "n", "tgs", ":TSLspOrganize<CR>")
    mapBuf(bufnr, "n", "tgr", ":TSLspRenameFile<CR>")
    mapBuf(bufnr, "n", "tgo", ":TSLspImportAll<CR>")

    on_attach(client, bufnr)
  end,
})

-- CSS
lsp.ccls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    scss = {
      lint = {
        idSelector = "warning",
        zeroUnits = "warning",
        duplicateProperties = "warning",
      },
      completion = {
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
    },
  },
})

-- Go
lsp.gopls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    on_attach(client, bufnr)
  end,
})

-- GraphQL
lsp.graphql.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- HTML
lsp.html.setup({
  capabilities = capabilities,
})

-- JSON
lsp.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Omnisharp
local pid = vim.fn.getpid()
local omnisharp_bin = os.getenv("HOME") .. "/.local/bin/omnisharp/run"
lsp.omnisharp.setup({
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Prisma
lsp.prismals.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Svelte
lsp.svelte.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- TailwindCSS
lsp.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- VUE
lsp.volar.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Yaml
lsp.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.diagnostic.show_line_diagnostics()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  underline = true,
  update_on_insert = true,
})

local signs = {
  Error = "ﰸ",
  Warn = "",
  Hint = "",
  Info = "",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = nil,
  })
end

vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]])

return on_attach
