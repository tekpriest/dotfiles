local wezterm = require 'wezterm'
local act = wezterm.action
local plugin = wezterm.plugin
local resurrect = plugin.require 'https://github.com/MLFlexer/resurrect.wezterm'
local workspace_switcher =
  plugin.require 'https://github.com/MLFlexer/smart_workspace_switcher.wezterm'

return {
  apply_to_config = function(config)
    config.leader = { key = 'x', mods = 'CTRL', timeout_milliseconds = 1000 }
    config.keys = {
      -- send C-a when pressing C-a twice
      {
        key = 'a',
        mods = 'LEADER',
        action = act.SendKey { key = 'a', mods = 'CTRL' },
      },
      { key = 'c', mods = 'LEADER', action = act.ActivateCopyMode },

      -- pane keybindings
      {
        key = '-',
        mods = 'LEADER',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' },
      },
      -- SHIFT is for when caps lock is on
      {
        key = '|',
        mods = 'LEADER|SHIFT',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
      },
      {
        key = 'h',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Left',
      },
      {
        key = 'j',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Down',
      },
      {
        key = 'k',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Up',
      },
      {
        key = 'l',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Right',
      },
      {
        key = 'x',
        mods = 'LEADER',
        action = act.CloseCurrentPane { confirm = true },
      },
      {
        key = 'q',
        mods = 'LEADER',
        action = act.QuitApplication,
      },
      {
        key = 'z',
        mods = 'LEADER',
        action = act.TogglePaneZoomState,
      },
      {
        key = 'r',
        mods = 'LEADER',
        action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false },
      },

      -- Tab keybindings
      {
        key = 't',
        mods = 'LEADER',
        action = act.SpawnTab 'CurrentPaneDomain',
      },
      { key = '[', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
      { key = ']', mods = 'LEADER', action = act.ActivateTabRelative(1) },
      {
        key = 'e',
        mods = 'LEADER',
        action = act.PromptInputLine {
          description = wezterm.format {
            { Attribute = { Intensity = 'Bold' } },
            { Foreground = { AnsiColor = 'Fuchsia' } },
            { Text = 'Renaming Tab Title...:' },
          },
          action = wezterm.action_callback(function(window, _, line)
            if line then
              window:active_tab():set_title(line)
            end
          end),
        },
      },
      -- Key table for moving tabs around
      {
        key = 'm',
        mods = 'LEADER',
        action = act.ActivateKeyTable { name = 'move_tab', one_shot = false },
      },
      -- {
      --   key = 's',
      --   mods = 'LEADER',
      --   action = wezterm.action_callback(function(win, pane)
      --     resurrect.fuzzy_load(win, pane, function(id, _)
      --       local type = string.match(id, '^([^/]+)') -- match before '/'
      --       id = string.match(id, '([^/]+)$') -- match after '/'
      --       id = string.match(id, '(.+)%..+$') -- remove file extension
      --       local state
      --       if type == 'workspace' then
      --         state = resurrect.load_state(id, 'workspace')
      --         resurrect.workspace_state.restore_workspace(state, {
      --           relative = true,
      --           restore_text = true,
      --           on_pane_restore = resurrect.tab_state.default_on_pane_restore,
      --         })
      --       elseif type == 'window' then
      --         state = resurrect.load_state(id, 'window')
      --         resurrect.window_state.restore_window(pane:window(), state, {
      --           relative = true,
      --           restore_text = true,
      --           on_pane_restore = resurrect.tab_state.default_on_pane_restore,
      --           -- uncomment this line to use active tab when restoring
      --           -- tab = win:active_tab(),
      --         })
      --       end
      --     end)
      --   end),
      -- },
      {
        key = 'p',
        mods = 'LEADER',
        action = workspace_switcher.switch_workspace(),
      },
      {
        key = 'g',
        mods = 'LEADER',
        action = act.SpawnCommandInNewTab {
          label = ' ',
          args = { '/opt/homebrew/bin/lazygit' },
        },
      },
    }
  end,
}
