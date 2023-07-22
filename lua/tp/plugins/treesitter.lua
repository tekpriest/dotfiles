return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      {
        'nvim-treesitter/playground',
        cmd = 'TSPlaygroundToggle',
      },
    },
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
    build = ':TSUpdate',
    event = 'VeryLazy',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'cuda',
        'dockerfile',
        'go',
        'gomod',
        'gosum',
        'hcl',
        'html',
        'javascript',
        'json',
        'json5',
        'jsonc',
        'lua',
        'markdown',
        'markdown_inline',
        'objc',
        'prisma',
        'proto',
        'python',
        'regex',
        'sql',
        'svelte',
        'terraform',
        'toml',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
      },
      auto_install = true,
      autopairs = { enabled = true },
      highlight = {
        enable = true,
        disable = function(lang, bufnr)
          return vim.bo.filetype == 'help'
        end,
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- mappings for incremental selection (visual mappings)
          init_selection = '<CR>', -- maps in normal mode to init the node/scope selection
          node_incremental = 'grn', -- increment to the upper named parent
          scope_incremental = 'grc', -- increment to the upper scope (as defined in locals.scm)
          node_decremental = 'grm', -- decrement to the previous node
        },
      },
      playground = {
        enable = true,
        updatetime = 25,
        persist_queries = false,
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { 'BufWrite', 'CursorHold' },
      },
      rainbow = {
        enable = true,
        extended_mode = false,
        max_file_lines = 3000,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
