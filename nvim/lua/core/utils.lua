_G.__tp_global_callbacks = __tp_global_callbacks or {}

_G.TP = {
_store = __tp_global_callbacks,
  mappings = {},

}

local g = vim.g
local set = vim.opt

TP.bootstrap_plugin = function ()
  local fn = vim.fn
  -- bootstrap packer
  local install_path = fn.stdpath("data").. "/site/pack/packer/opt/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify("downloading packer.nvim...")
    fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
  end
  vim.cmd("packadd! packer.nvim")
  --require('packer').sync()
end

TP.disabled_builtins = function()
  g.loaded_gzip = false
  g.loaded_netrwPlugin = false
  g.loaded_netrwSettngs = false
  g.loaded_netrwFileHandlers = false
  g.loaded_tar = false
  g.loaded_tarPlugin = false
  g.zipPlugin = false
  g.loaded_zipPlugin = false
  g.loaded_2html_plugin = false
  g.loaded_remote_plugins = false
  set.shadafile = "NONE"
end

TP.impatient = function()
  local impatient_ok, _ = pcall(require, "impatient")
  if impatient_ok then
    require("impatient").enable_profile()
  end
end

TP.require = function (module, opts)
  opts = opts or {silent=false}
 local ok, module_found = pcall(require, module)
  if not ok and not opts.silent then
    vim.notify(string.format("%s not found",module))
    return
  end
  return module_found
end
