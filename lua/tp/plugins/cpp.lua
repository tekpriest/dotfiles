local Utils = require 'tp.utils'
local cmd = {
  'clangd',
  '--background-index',
  '--clang-tidy',
  '--completion-style=detailed',
  '--header-insertion=iwyu',
  '--cross-file-rename',
  '--all-scopes-completion',
  '--suggest-missing-includes',
  '--pch-storage=memory',
}

local config = {
  capabilities = Utils.capabilities(),
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  cmd = cmd,
  on_attach = Utils.on_attach,
}

local extensions = {
  autoSetHints = false,
  memory_usage = { border = 'rounded' },
  symbol_info = { border = 'rounded' },
  ast = {
    role_icons = {
      type = '',
      declaration = '',
      expression = '',
      specifier = '',
      statement = '',
      ['template argument'] = '',
    },
    kind_icons = {
      Compound = '',
      Recovery = '',
      TranslationUnit = '',
      PackExpansion = '',
      TemplateTypeParm = '',
      TemplateTemplateParm = '',
      TemplateParamObject = '',
    },
  },
}
return {
  {
    ft = { 'c', 'cpp', 'objc', 'obcpp', 'cuda', 'proto' },
    -- 'https://git.sr.ht/~p00f/clangd_extensions.nvim',
    -- config = function()
    --   require('clangd_extensions').setup {
    --     server = config,
    --     extensions = extensions,
    --   }
    -- end,
    'ranjithshegde/ccls.nvim',
    -- config = function()
    --   require('ccls').setup {
    --     lsp = {
    --       server = {
    --         -- name = 'ccls',
    --         -- cmd = { '/usr/local/bin/ccls' },
    --         -- args = {},
    --         -- offset_encoding = 'utf-32',
    --         -- root_dir = vim.fs.dirname(
    --         --   vim.fs.find { 'compile_commands.json', '.git', '.ccls' } {
    --         --     upward = true,
    --         --   }
    --         -- ),
    --         init_options = {
    --           index = {
    --             threads = 0,
    --           },
    --           clang = {
    --             excludeArgs = { '-frounding-math' },
    --           },
    --         },
    --         on_attach = require('tp.lsp.setup').on_attach,
    --         capabilities = require('tp.lsp.setup').capabilities,
    --         flags = {
    --           allow_incremental_sync = false,
    --           debounce_text_changes = 100,
    --         },
    --       },
    --       codelens = {
    --         enable = true,
    --       },
    --     },
    --   }
    -- end,
  },
  {
    'https://git.sr.ht/~p00f/clangd_extensions.nvim',
    ft = { 'c', 'cpp', 'objc', 'obcpp', 'cuda', 'proto' },
    config = function()
      require('clangd_extensions').setup {
        server = config,
        extensions = extensions,
      }
    end,
  },
}
