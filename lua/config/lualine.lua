local gps = require('nvim-gps')

require('lualine').setup({
  sections = {
    lualine_c = {
      {gps.get_location, condition = gps.is_available}
    }
  }
})
