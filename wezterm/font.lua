local function get(weight)
  return require('wezterm').font('DankMono Nerd Font Mono', { weight = weight })
end

return {
  get = get,
  apply_to_config = function(config)
    config.font = get()
    config.font_size = 9
  end
}
