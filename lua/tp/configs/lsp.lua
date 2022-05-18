local lsp = require("lspconfig")
local lsp_util = require("lspconfig.util")
local cmp_lsp = require("cmp_nvim_lsp")
local status = require("lsp-status")
local null = require("null-ls")

-- Lua
local path = vim.split(package.path, ";")
table.insert(path, "lua/?.lua")
table.insert(path, "lua/?/init.lua")

-- register status progress
status.register_progress()

require("lspkind").init()
require("lspsaga").init_lsp_saga()

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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = "rounded", focusable = false }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "rounded" }
)

local on_attach = function(client, bufnr)
  local opts = { silent = true, noremap = true }
  status.on_attach(client)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- use lsp as the handler for formatexpr
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gD",
    "<cmd>lua vim.lsp.buf.declaration()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gd",
    "<cmd>lua vim.lsp.buf.definition()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "td",
    "<cmd>lua vim.lsp.buf.type_definition()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gi",
    "<cmd>lua vim.lsp.buf.implementation()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gr",
    "<cmd>lua vim.lsp.buf.references()<CR>",
    opts
  )
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gla", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(
  -- 	bufnr,
  -- 	"n",
  -- 	"[d",
  -- 	'<cmd>lua vim.diagnostic.goto_prev({ border = "rounded", severity = vim.diagnostic.severity.ERROR })<CR>',
  -- 	opts
  -- )
  -- vim.api.nvim_buf_set_keymap(
  -- 	bufnr,
  -- 	"n",
  -- 	"]d",
  -- 	'<cmd>lua vim.diagnostic.goto_next({ border = "rounded", severity = vim.diagnostic.severity.ERROR })<CR>',
  -- 	opts
  -- )
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>p", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting_sync()' ]])
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command(
      "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
    )
  end
  -- code highlight
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_command(
      "autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()"
    )
    vim.api.nvim_command(
      "autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()"
    )
    vim.api.nvim_command(
      "autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()"
    )
  end
  if client.resolved_capabilities.code_lens then
    vim.api.nvim_command(
      "autocmd BufEnter,CursorHold,InsertLeave, <buffer> lua vim.lsp.codelens.refresh()"
    )
  end
end
-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_lsp.update_capabilities(capabilities)
capabilities = vim.tbl_extend("keep", capabilities or {}, status.capabilities)

local servers = {
  gopls = {
    settings = {
      gopls = {
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        experimentalPostfixCompletions = true,
        gofumpt = true,
        staticcheck = true,
        usePlaceholders = true,
      },
    },
    on_attach = on_attach,
    capabilities = capabilities,
  },
  tsserver = {
    init_options = require("nvim-lsp-ts-utils").init_options,
    on_attach = function(client, bufnr)
      local ts_utils = require("nvim-lsp-ts-utils")

      ts_utils.setup({
        enable_import_on_completion = true,
        update_imports_on_save = true,
      })
      ts_utils.setup_client(client)

      local opts = { silent = true }
      vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gs",
        "<cmd>TSLspOrganize<CR>",
        opts
      )
      vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gr",
        "<cmd>TSLspRenameFile<CR>",
        opts
      )
      vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gi",
        "<cmd>TSLspImportAll<CR>",
        opts
      )

      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
    end,
    -- on_attach = on_attach,
    capabilities = capabilities,
    vim.cmd([[  augroup _organize_imports
    autocmd!
    autocmd BufWritePre *.ts,*tsx TSLspOrganize
  augroup end]]),
  },
  sumneko_lua = {
    cmd = { "lua-language-server" },
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "it", "describe" },
        },
        runtime = {
          version = "LuaJIT",
          path = path,
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  },
  jsonls = {
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  },
  zls = {
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
  eslint = {
    root_dir = lsp_util.root_pattern({
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.json",
    }),
    on_attach = on_attach,
    capabilities = capabilities,
  },
  jdtls = {
    cmd = {
      "java",

      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms4g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",

      "-jar",
      "/Users/tp/.local/bin/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
      "-configuration",
      "/Users/tp/.local/bin/jdtls/config_mac",
      "-data",
      "/Users/tp/Code" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
    },
    on_attach = on_attach,
    capabilities = capabilities,
  },
  prisma = {
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
lsp.eslint.setup(servers.eslint)
lsp.jdtls.setup(servers.jdtls)
lsp.prismals.setup(servers.prisma)

-- rust
local extension_path = vim.env.HOME
  .. "/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

local opts = {
  tools = {
    autoSetHints = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefic = "",
    },
  },
  server = {
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importEnforceGranularity = true,
          importPrefix = "crate",
        },
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = "clippy",
        },
        inlayHints = {
          lifetimeElisionHints = {
            enable = "always",
            useParameterNames = true,
          },
        },
        lens = {
          references = true,
          methodReferences = true,
        },
        rustfmt = {},
      },
    },
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(
      codelldb_path,
      liblldb_path
    ),
  },
}

require("rust-tools").setup(opts)

-- CCLS
require("clangd_extensions").setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
})

local b = null.builtins
null.setup({
  sources = {
    -- b.code_actions.eslint_d,
    -- b.diagnostics.eslint_d,
    b.formatting.stylua,
    b.formatting.rustfmt,
    b.formatting.prettier,
  },
  on_attach = on_attach,
  capabilities = capabilities,
})
