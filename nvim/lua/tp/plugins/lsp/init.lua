return {
  -- lspconfig
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
      { 'folke/neodev.nvim', opts = { experimental = { pathStrict = true } } },
      'mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/typescript.nvim',
      {
        'hrsh7th/cmp-nvim-lsp',
        cond = function()
          return require('tp.core._util').has 'nvim-cmp'
        end,
      },
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        -- underline = true,
        update_in_insert = true,
        virtual_text = { spacing = 4, prefix = '■' },
        severity_sort = true,
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      },
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overriden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        jsonls = {},
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
              },
              completion = {
                callSnippet = 'Replace',
              },
              runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
              },
              diagnostics = {
                globals = { 'vim' },
              },
              hint = {
                enable = true,
              },
            },
          },
        },
        cssls = {},
        graphql = {},
        prismals = {},
        dockerls = {},
        html = {},
        bashls = {},
        tailwindcss = {
          root_dir = function()
            require('lspconfig').util.root_pattern 'tailwind.config.js'
          end,
        },
        taplo = {},
        denols = {
          root_dir = function()
            require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc')
          end,
        },
        marksman = {},
        lemminx = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- tsserver =function (_, opts)
        --
        -- end
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- setup autoformat
      require('tp.plugins.lsp.format').autoformat = opts.autoformat
      -- setup formatting and keymaps
      require('tp.core._util').on_attach(function(client, buffer)
        require('tp.plugins.lsp.format').on_attach(client, buffer)
        require('tp.plugins.lsp.keymaps').on_attach(client, buffer)
      end)

      -- diagnostics
      for name, icon in pairs(require('tp.core').icons.diagnostics) do
        name = 'DiagnosticSign' .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
      end
      vim.diagnostic.config(opts.diagnostics)

      local servers = opts.servers
      local capabilities =
        require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local function setup(server)
        local server_opts = servers[server] or {}
        server_opts.capabilities = capabilities
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

      local mlsp = require 'mason-lspconfig'
      local available = mlsp.get_available_servers()

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require('mason-lspconfig').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup_handlers { setup }
    end,
  },

  -- formatters
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    dependencies = { 'mason.nvim' },
    opts = function()
      local nls = require 'null-ls'
      return {
        sources = {
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.flake8,
          nls.builtins.formatting.rustfmt,
          nls.builtins.formatting.dprint,
        },
      }
    end,
  },

  -- cmdline tools and lsp servers
  {

    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    opts = {
      ensure_installed = {
        'stylua',
        'shellcheck',
        'shfmt',
        'flake8',
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require 'mason-registry'
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },

  {
    'j-hui/fidget.nvim',
    config = true,
  },
}
