local ts = require("nvim-treesitter.configs")
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.org = {
  install_info = {
    url = "https://github.com/milisims/tree-sitter-org",
    revision = "f110024d539e676f25b72b7c80b0fd43c34264ef",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  filetype = "org",
}

ts.setup({
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
  },
  context_commentstring = { enable = true },
  raibow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  autotag = {
    enable = true,
    filetypes = { "html", "javascript", "typescript", "markdown" },
  },

  ignore_installed = { "haskell" },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<TAB>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    lsp_interop = {
      enable = true,
      border = "none",
      peek_definition_code = {
        ["<leader>pf"] = "@function.outer",
        ["<leader>pc"] = "@class.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
  -- indent = {
  --     enable = false
  -- },
  -- query_linter = {
  --     enable = true,
  --     use_virtual_text = true,
  --     lint_events = {"BufWrite", "CursorHold"}
  -- }
})

-- setup treesitter
ts.setup({
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "org" },
    -- use_languagetree = true,
    -- disable = { "haskell" },
  },
})
