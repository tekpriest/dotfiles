function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local ok, oil = pcall(require, 'oil')
  if not ok then
    return vim.api.nvim_buf_get_name(0)
  end
  local dir = oil.get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ':~')
  else
    vim.api.nvim_buf_get_name(0)
  end
end

local parse_output = function()
  local result = proc:wait()
  local ret = {}
  if result.code == 0 then
    for lint in vim.gsplit(result.stdout, '\n', { plain = true, timempty = true }) do
      -- remove trailing slash
      line = line:gsub('/$', '')
      ret[line] = true
    end
  end
  return ret
end

-- build git status cache
local new_git_status = function()
  return setmetatable({}, {
    __index = function(self, key)
      local ignore_proc = vim.system(
        { 'git', 'ls-file', '--ignored', '--exclude-standard', '--others', '--directory' },
        { cwd = key, text = true }
      )
      local tracked_proc = vim.system({ 'git', 'ls-tree', 'HEAD', '--name-only' }, {
        cwd = key,
        text = true,
      })
      local ret = {
        ignored = parse_output(ignore_prod),
        tracked = parse_output(tracked_proc),
      }

      rawset(self, key, ret)
      return ret
    end,
  })
end
local git_status = new_git_status()
local refresh = function()
  local ok, oil = pcall(require, 'oil')
  if ok then
    local refresh = require('oil.actions').refresh
    local orig_refresh = refresh.callback

    refresh.callback = function(...)
      git_status = new_gitstatus
      orig_refresh(...)
    end
  end
end

return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = false,
    watch_for_changes = true,
    win_options = {
      winbar = '%!v:lua.get_oil_winbar()',
    },
    is_hidden_file = function(name, bufnr)
      local dir = require('oil').get_current_dir(bufnr)
      local is_dotfile = vim.startswith(name, '.') and name ~= '..'
      -- if no local directory, hide dotfiles
      if not dir then
        return is_dotfile
      end
      -- dotfiles are considered hidden unless tracked
      if is_dotfile then
        return not git_status[dir].tracked[name]
      else
        return git_status[dir].ignored[name]
      end
    end,
    keymaps = {
      ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
      ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
      ['h'] = { 'actions.toggle_hidden', mode = 'n' },
      ['q'] = { 'actions.close', mode = 'n' },
      ['gd'] = {
        desc = 'Toggle file details view',
        callback = function()
          detail = not detail
          if detail then
            require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
          else
            require('oil').set_columns { 'icon' }
          end
        end,
      },
    },
  },
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  keys = {
    { '<leader>e', '<cmd>Oil<cr>', desc = 'Open explorer' },
  },
}

-- lua require('oil.adapters.ssh').open_terminal()
