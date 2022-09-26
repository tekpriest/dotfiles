local plugins = {
  -- "lsp",
}

for k, v in ipairs(plugins) do
  local plugin = "tp.configs.plugins." .. v
  require(plugin)
end
