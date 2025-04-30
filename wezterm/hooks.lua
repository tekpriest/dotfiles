local wezterm = require 'wezterm'
local plugin = wezterm.plugin
local resurrect = plugin.require 'resurrect.wezterm'

wezterm.on('smart_workspace_switcher.workspace_switcher.chosen', function(window, workspace)
  local gui_win = window:gui_window()
  local base_path = string.gsub(workspace, '(.*[/\\])(.*)', '%2')
  gui_win:set_right_status(wezterm.format {
    { Foreground = { Color = 'green' } },
    { Text = base_path .. '  ' },
  })
end)

wezterm.on(
  'smart_workspace_switcher.workspace_switcher.created',
  function(window, path, label, workspace)
    local workspace_state = resurrect.workspace_state()

    local gui_win = window:gui_window()
    local base_path = string.gsub(workspace, '(.*[/\\])(.*)', '%2')
    gui_win:set_right_status(wezterm.format {
      { Foreground = { Color = 'green' } },
      { Text = base_path .. '  ' },
    })

    workspace_state.restore_workspace(resurrect.load_state(label, 'workspace'), {
      window = window,
      relative = true,
      restore_text = true,
      on_pane_restore = resurrect.tab_state.default_on_pane_restore,
    })
  end
)

wezterm.on('smart_workspace_switcher.workspace_switcher.selected', function(window, path, label)
  local workspace_state = resurrect.workspace_state
  resurrect.save_state(workspace_state.get_workspace_state())
end)
