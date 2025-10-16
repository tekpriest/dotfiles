return {
  {
    'mistweaverco/kulala.nvim',
    -- stylua: ignore start
    keys = {
      { "<leader>r", "", desc = "+Rest" },
      { "<leader>rb", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad" },
      { "<leader>rc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL" },
      { "<leader>rC", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste from curl" },
      {
        "<leader>rg",
        "<cmd>lua require('kulala').download_graphql_schema()<cr>",
        desc = "Download GraphQL schema",
        ft = "http",
      },
      { "<leader>ri", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect current request" },
      { "<leader>rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
      { "<leader>rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
      { "<leader>rq", "<cmd>lua require('kulala').close()<cr>", desc = "Close window" },
      { "<leader>rr", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay the last request" },
      { "<leader>rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request" },
      { "<leader>rS", "<cmd>lua require('kulala').show_stats()<cr>", desc = "Show stats" },
      { "<leader>rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
    },
    -- stylua: ignore end
    opts = {
      global_keymaps_prefix = '<leader>r',
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'http', 'graphql' },
    },
  },
}
