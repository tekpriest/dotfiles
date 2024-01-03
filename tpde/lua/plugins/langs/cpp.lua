return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'cpp', 'c', 'objc', 'cuda', 'proto', 'cmake' })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'clangd' })
    end,
  },
  {
    'Civitasv/cmake-tools.nvim',
    ft = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    dependencies = {
      -- {
      --   'jay-babu/mason-nvim-dap.nvim',
      --   opts = function(_, opts)
      --     opts.ensure_installed = vim.list_extend(opts.ensure_installed, { 'codelldb' })
      --   end,
      -- },
    },
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    dependecies = {
      {
        'p00f/clangd_extensions.nvim',
        -- ft = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
        init = function()
          -- load clangd extensions when clangd attaches
          local augroup = vim.api.nvim_create_augroup('clangd_extensions', { clear = true })
          vim.api.nvim_create_autocmd('LspAttach', {
            group = augroup,
            desc = 'Load clangd_extensions with clangd',
            callback = function(args)
              if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == 'clangd' then
                require 'clangd_extensions'
                vim.api.nvim_del_augroup_by_id(augroup)
              end
            end,
          })
        end,
      },
    },
    opts = {
      servers = {
        clangd = {
          on_new_config = function(new_config, new_cwd)
            local ok, cmake = pcall(require, 'cmake-tools')
            if ok then
              cmake.clangd_on_new_config(new_config)
            end
          end,
        },
      },
    },
  },
}
