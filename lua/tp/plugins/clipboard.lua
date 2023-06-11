local function is_whitespace(line)
  return vim.fn.match(line, [[^\s*$]]) ~= -1
end

local function all(tbl, check)
  for _, entry in ipairs(tbl) do
    if not check(entry) then
      return false
    end
  end
  return true
end

return {
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      { 'kkharji/sqlite.lua', name = 'sqlite' },
    },
    init = function()
      require('telescope').load_extension 'neoclip'
    end,
    event = 'VeryLazy',
    config = function()
      require('neoclip').setup {
        filter = function(data)
          return not all(data.event.regcontents, is_whitespace)
        end,
        -- enable_persistent_history = false,
        -- history = 100000,
        -- continuous_sync = true,
        -- enable_macro_history = false,
        -- default_register_macros = '',
      }
    end,
  },
}
