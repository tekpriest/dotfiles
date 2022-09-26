local lsp = require 'lspconfig'
local cmp_lsp = require 'cmp_nvim_lsp'
local null = require 'null-ls'
local illuminate = require 'illuminate'
local lsp_installer = require 'nvim-lsp-installer'
local lsp_util = require 'lspconfig.util'
local flutter = require 'flutter-tools'
local prettier = require 'prettier'
local mason = require 'mason'
local mason_lsp = require 'mason-lspconfig'

require('lua-dev').setup {}

lsp_installer.setup({})
require('lspkind').init()
require('lspsaga').init_lsp_saga()

local protocol = require 'vim.lsp.protocol'

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

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- diagnostic
vim.diagnostic.config {
  virtual_text = false,
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

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded', focusable = false })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

mason.setup {}
mason_lsp.setup {
  ensure_installed = { 'sumneko_lua', 'tailwindcss', 'typescript', 'solidity', 'rust_analyzer' },
}

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
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('Format', { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
  if client.server_capabilities.code_lens then
    vim.api.nvim_command 'autocmd BufEnter,CursorHold,InsertLeave, <buffer> lua vim.lsp.codelens.refresh()'
  end
  illuminate.on_attach(client)
  lsp_keymaps(bufnr)
end

local capabilities = protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp_lsp.update_capabilities(capabilities)

local add_server = function(server_name, opts)
  lsp[server_name].setup(opts)
end

add_server('sumneko_lua', {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
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
  on_attach = on_attach,
  filetypes = {
    'typescriptreact',
    'typescript',
    'javascript',
    'javascriptreact',
    'typescript.tsx',
    'javascript.jsx',
  },
  cmd = { 'typescript-language-server', '--stdio' },
  capabilities = capabilities,
})

add_server('rust_analyzer', {
  on_attach = on_attach,
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
    client.server_capabilities.documentFormattingProvider = false
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

add_server('solc', {
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

add_server('efm', {
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
      -- background = true,
    },
    on_attach = on_attach,
    capabilities = capabilities,
  },
}

local b = null.builtins
null.setup {
  sources = {
    -- b.formatting.prettierd,
    b.formatting.stylua,
    b.diagnostics.eslint_d.with {
      diagnostics_format = '[eslint] #{m}\n(#{c})',
    },
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd 'nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.format()<CR>'

      -- format on save
      vim.cmd 'autocmd BufWritePost <buffer> lua vim.lsp.buf.format()'
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd 'xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_format({})<CR>'
    end
  end,
}

prettier.setup {
  bin = 'prettierd',
  cli_options = {
    config_precedence = 'prefer-file',
    jsx_single_quote = true,
    semi = true,
    single_quote = true,
    trailing_comman = 'es5',
    embedded_language_formatting = 'auto',
  },
}
