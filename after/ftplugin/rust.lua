local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

wk.register({
  ["<leader>r"] = {
    name = "+Rust",
    f = { "<cmd>RustFmt<cr>", "format code" },
    r = { "<cmd>RustRun<cr>", "run code" },
    o = { "<cmd>RustOpenCargo<cr>", "open cargo file" },
    t = { "<cmd>RustTest<cr>", "run test" },
    p = { "<cmd>RustPlay<cr>", "share code" },
    m = {
      name = "+move",
      u = { "<cmd>RustMoveItemUp<cr>", "move item up" },
      d = { "<cmd>RustMoveItemDown<cr>", "move item down" },
    },
  },
})
