local M = {}

local cache = {
  value = '',
  timestamp = 0,
  interval = 60, -- in seconds (5 minutes)
}

local refresh_wakatime = function()
  local now = os.time()

  if now - cache.timestamp > cache.interval then
    -- only update if interval has passed
    local ok, today = pcall(vim.api.nvim_exec2, 'WakaTimeToday', { output = true })
    if ok and today.output then
      print(ok)
      print(today.output)
      cache.value = today.output:gsub('\n', ' ')
      cache.timestamp = now
    end
  end

  return cache.value
end

return {
  provider = refresh_wakatime(),
  hl = { fg = '#54546D' },
}
