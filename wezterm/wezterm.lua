local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font_with_fallback {
  { family = 'OperatorMono Nerd Font', weight = 'Light' },
  { family = 'Dank Mono' },
}
-- config.font = wezterm.font{k}
config.font_size = 9.8
config.window_background_opacity = 0.95
config.window_decorations = 'RESIZE'
-- config.window_close_confirmation = 'AlwaysPrompt'
config.scrollback_lines = 3000
config.default_workspace = 'Code'
config.enable_tab_bar = false

-- dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.5,
}

-- remove fancy tab bar
config.use_fancy_tab_bar = false
config.status_update_interval = 5000
wezterm.on('update-right-status', function(window, pane)
  local active_workspace = window:active_workspace()

  local time = wezterm.strftime '%H:%M:%S'

  window:set_right_status(wezterm.format {
    { Foreground = { Color = 'FFB86C' } },
    { Text = wezterm.nerdfonts.oct_table .. ' ' .. active_workspace },
    -- { Text = wezterm.nerdfonts.oct_table .. " " .. cwd },
    -- 'ResetAttributes',
    -- { Text = ' | ' },
    -- { Text = wezterm.nerdfonts.md_clock .. ' ' .. time },
  })
end)

-- keys
config.leader = { key = 'x', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- send C-a when pressing C-a twice
  {
    key = 'x',
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
    key = 'z',
    mods = 'LEADER',
    action = act.TogglePaneZoomState,
  },
  {
    key = 't',
    mods = 'LEADER',
    action = act.RotatePanes 'Clockwise',
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false },
  },

  -- Tab keybindings
  {
    key = 'n',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  { key = '[', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 's', mods = 'LEADER', action = act.ShowTabNavigator },
  {
    key = 'e',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Renaming Tab Title...:' },
      },
      action = wezterm.action_callback(function(window, pane, line)
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

  -- Lastly, workspace
  {
    key = 'w',
    mods = 'LEADER',
    action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
  {
    key = 'W',
    mods = 'LEADER|SHIFT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter new workspace name' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(act.SwitchToWorkspace { name = line }, pane)
        end
      end),
    },
  },

  {
    key = 'g',
    mods = 'LEADER',
    action = act.SpawnCommandInNewWindow {
      label = ' ',
      args = { 'lazygit' },
    },
  },
}

-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = act.ActivateTab(i - 1),
  })
end

config.key_tables = {
  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  },
  move_tab = {
    { key = 'h', action = act.MoveTabRelative(-1) },
    { key = 'j', action = act.MoveTabRelative(-1) },
    { key = 'k', action = act.MoveTabRelative(1) },
    { key = 'l', action = act.MoveTabRelative(1) },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  },
}
return config
