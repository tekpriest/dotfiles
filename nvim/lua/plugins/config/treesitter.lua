local ts = require("nvim-treesitter.configs")

ts.setup({
    raibow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
    },
    autotag = {
        enable = true,
        filetypes = {"html", "javascript", "typescript", "markdown"}
    },

    ignore_installed = {"haskell"},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<TAB>"
        }
    }
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
        enable = true
        -- use_languagetree = true,
        -- disable = { "haskell" },
    }

})
