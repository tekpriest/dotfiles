local lsp = require 'lspconfig'
local cmp_lsp = require 'cmp_nvim_lsp'
local null = require 'null-ls'
local illuminate = require 'illuminate'
local utils = require 'tp.configs.plugins.lsp_utils'
local lsp_installer = require 'nvim-lsp-installer'
local lsp_util = require 'lspconfig.util'
local flutter = require 'flutter-tools'

lsp_installer.setup()
require('lspkind').init()
require('lspsaga').init_lsp_saga()

for type, icon in pairs(utils.signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = nil,
  })
end

-- diagnostic
vim.diagnostic.config(utils.diagnostic)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded', focusable = false })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gtd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- use lsp as the handler for formatexpr
  vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

  if client.server_capabilities.documentFormattingProvider then
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting_sync()' ]]
    vim.api.nvim_command 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()'
  end
  if client.server_capabilities.code_lens then
    vim.api.nvim_command 'autocmd BufEnter,CursorHold,InsertLeave, <buffer> lua vim.lsp.codelens.refresh()'
  end
  illuminate.on_attach(client)
  lsp_keymaps(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp_lsp.update_capabilities(capabilities)

local add_server = function(server_name, opts)
  lsp[server_name].setup(opts)
end

add_server('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          [vim.fn.expand '$VIMRUNTIME/lua'] = true,
          [vim.fn.expand('config' .. '/lua')] = true,
        },
      },
      telemetry = {
        enable = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, bufnr)
  end,
  -- on_attach = on_attach,
  capabilities = capabilities,
})
add_server('tsserver', {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, bufnr)
  end,
  -- on_attach = on_attach,
  capabilities = capabilities,
})

add_server('gopls', {
  settings = {
    gopls = {
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedany = true,
      },
      experimentalPostfixCompletions = true,
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
})

add_server('zls', {
  on_attach = on_attach,
  capabilities = capabilities,
})

add_server('prismals', {
  on_attach = on_attach,
  capabilities = capabilities,
})

add_server('jsonls', {
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
})

add_server('cmake', {
  on_attach = on_attach,
  capabilities = capabilities,
})

add_server('eslint', {
  root_dir = lsp_util.root_pattern { '.eslintrc', '.eslintrc.js', '.eslintrc.json' },
  on_attach = on_attach,
  capabilities = capabilities,
})

add_server('elixirls', {
  on_attach = on_attach,
  capabilities = capabilities,
})

add_server('dockerls', {
  on_attach = on_attach,
  capabilities = capabilities,
})

add_server('tflint', {
  on_attach = on_attach,
  capabilities = capabilities,
})

add_server('taplo', {
  on_attach = on_attach,
  capabilities = capabilities,
})

add_server('svelte', {
  on_attach = on_attach,
  capabilities = capabilities,
})

add_server('emmet_ls', {
  cmd = { 'ls_emmet', '--stdio' },
  filetypes = {
    'html',
    'css',
    'scss',
    'javascriptreact',
    'typescriptreact',
    'haml',
    'xml',
    'xsl',
    'pug',
    'slim',
    'sass',
    'stylus',
    'less',
    'sss',
    'hbs',
    'handlebars',
  },
})

add_server('tailwindcss', {
  on_attach = on_attach,
  capabilities = capabilities,
})

flutter.setup {
  widget_guides = {
    enabled = true,
  },
  lsp = {
    color = {
      enabled = true,
      foreground = true,
      background = true,
    },
    on_attach = on_attach,
    capabilities = capabilities,
  },
}

local b = null.builtins
null.setup {
  sources = {
    b.formatting.prettier,
    b.formatting.stylua,
  },
  on_attach = on_attach,
  capabilities = capabilities,
}
