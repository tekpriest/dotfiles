local function get(weight)
  return require('wezterm').font('OperatorMonoLig Nerd Font Mono', { weight = weight or 'Regular' })
end

return {
  get = get,
  apply_to_config = function(config)
    config.font = get()
    config.font_size = 10
  end,
}
