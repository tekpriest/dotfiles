local pick = nil

pick = function()
  local fzf_lua = require 'fzf-lua'
  local workspaces = require 'workspaces'
  local utils = require 'fzf-lua.utils'

  local function hl_validate(hl)
    return not utils.is_hl_cleared(hl) and hl or nil
  end

  local function ansi_from_hl(hl, s)
    return utils.ansi_from_hl(hl_validate(hl), s)
  end

  local opts = {
    fzf_colors = true,
    -- fzf_opts = {
    --   ['--header'] = string.format(
    --     ':: <%s> to %s | <%s> to %s | <%s> to %s | <%s> to %s | <%s> to %s',
    --     ansi_from_hl('FzfLuaHeaderBind', 'ctrl-t'),
    --     ansi_from_hl('FzfLuaHeaderText', 'tabedit'),
    --     ansi_from_hl('FzfLuaHeaderBind', 'ctrl-s'),
    --     ansi_from_hl('FzfLuaHeaderText', 'live_grep'),
    --     ansi_from_hl('FzfLuaHeaderBind', 'ctrl-r'),
    --     ansi_from_hl('FzfLuaHeaderText', 'oldfiles'),
    --     ansi_from_hl('FzfLuaHeaderBind', 'ctrl-w'),
    --     ansi_from_hl('FzfLuaHeaderText', 'change_dir'),
    --     ansi_from_hl('FzfLuaHeaderBind', 'ctrl-d'),
    --     ansi_from_hl('FzfLuaHeaderText', 'delete')
    --   ),
    -- },
    actions = {
      ['default'] = {
        function(selected)
          workspaces.open(selected[1])
        end,
      },
    },
  }

  fzf_lua.fzf_exec(function(cb)
    local workspace_list = workspaces.get()

    for _, workspace in ipairs(workspace_list) do
      cb(workspace.name)
    end
  end, opts)
end

local to_possession_path = function(path)
  path = path:gsub('^' .. os.getenv 'HOME', '~')
  path = path:gsub('/$', '')
  return path
end
return {
  {
    'natecraddock/workspaces.nvim',
    dependencies = {
      'natecraddock/sessions.nvim',
      'nvim-telescope/telescope.nvim',
      'jedrzejboczar/possession.nvim',
    },
    lazy = false,
    init = function()
      require('telescope').load_extension 'workspaces'
    end,
    opts = {
      notify_info = false,
      hooks = {
        open_pre = function(_, path, _)
          local workspaces = require 'workspaces'
          local possessions_paths = require 'possession.paths'
          local possessions_config = require 'possession.config'
          local possessions_session = require 'possession.session'

          local curr_path = workspaces.path()
          if not curr_path then
            return
          end

          local autosave_info = possessions_session.autosave_info()
          if not possessions_config.autosave.on_load or not autosave_info then
            return
          end

          local next_session = possessions_paths.session(to_possession_path(path))
          if next_session:exists() then
            local session_data = vim.json.decode(next_session:read())
            if session_data.name == autosave_info.name then
              return
            end
          end

          possessions_session.autosave()
          -- vim.cmd [[ScopeSaveState]] -- scope.nvim
        end,
        open = function(_, path, _)
          path = to_possession_path(path)

          if require('possession.paths').session(path):exists() then
            require('possession.session').load(path, { skip_autosave = true })
            vim.cmd [[ScopeLoadState]] -- scope.nvim
          else
            require('possession.session').close()
          end
        end,
      },
    },
    keys = {
      { '<leader>wp', '<cmd>Telescope workspaces<cr>', desc = 'Switch workspace' },
      { '<leader>wb', '<cmd>Telescope scope buffers<cr>', desc = 'list buffers' },
    },
  },
  {
    'tiagovla/scope.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    init = function()
      require('telescope').load_extension 'scope'
    end,
  },
}
