local tscope = require('telescope')

tscope.setup {
  defaults = {
    layout_config = {prompt_position = "top"},
    sorting_strategy = "ascending"
  }
}

tscope.load_extension('notify')
