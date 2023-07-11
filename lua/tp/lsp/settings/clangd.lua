return {
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  on_new_config = function(new_config, new_cmd)
    local status, cmake = pcall(require, 'cmake-tools')
    if status then
      cmake.clangd_on_new_config(new_config)
    end
  end,
}
