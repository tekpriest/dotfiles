return {
  apply_to_config = function(config)
    config.check_for_updates = false
    config.automatically_reload_config = true
    config.quit_when_all_windows_are_closed = true
    config.color_scheme = 'Catppuccin Mocha'
    -- config.window_background_opacity = 0.9
    config.window_decorations = 'RESIZE'
    config.window_close_confirmation = 'NeverPrompt'
    config.scrollback_lines = 3000
    config.default_workspace = 'Code'
    -- dim inactive panes
    config.inactive_pane_hsb = {
      saturation = 0.24,
      brightness = 0.5,
    }
    config.status_update_interval = 3000
    -- config.front_end = 'WebGpu'
    config.webgpu_power_preference = 'HighPerformance'
    config.native_macos_fullscreen_mode = false
    config.animation_fps = 30
    config.enable_tab_bar = false
  end,
}
