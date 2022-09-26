local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = 'all',
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  context_commentstring = { enable = true, enable_autocmd = false },
  playground = {
    enable = true,
    updatetime = 25,
    persist_queries = false,
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css" } },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = nil,
    disable = { "html" },
  },
    incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<TAB>",
    },
  },
    query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  autotag = {
    enable = true,
  },
}
