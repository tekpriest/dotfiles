local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

-- vim.opt_local.spell = true
vim.opt_local.expandtab = false
vim.opt_local.textwidth = 100
vim.opt_local.softtabstop = 0
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.smarttab = true

wk.register({
  ['<leader>g'] = {
    name = "+Go",
    b = { "<cmd>GoBuild<CR>", 'build' },
    f = {
      name = '+fix/fill',
      s = { "<cmd>GoFillStruct<CR>", "fill struct" },
      p = { "<cmd>GoFixPlurals<CR>", "fix plurals" }
    },
    ie = { "<cmd>GoIfErr<CR>", 'if err' }
  }
})
