local status, dap = pcall(require, 'dap')
if not status then
  return
end

dap.adapters.node = {
  type = 'executable',
  command = 'node',
  args = '~/.local/share/nvim/mason/packages/node-debug2-adapter/node-debug2-adapter',
}
dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}
