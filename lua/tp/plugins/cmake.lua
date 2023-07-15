return {
  'Civitasv/cmake-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ft = { 'c', 'cpp', 'hpp' },
  cmd = 'CMake',
  config = function()
    require('cmake-tools').setup {
      cmake_build_directory_prefix = 'build',
    }

    local wk = require 'which-key'
    wk.register {
      c = {
        name = 'Code',
        g = {
          name = 'CMake',
          g = { '<cmd>CMakeGenerate<cr>', 'generate cmake' },
          b = { '<cmd>CMakeBuild<cr>', 'buld project' },
          r = { '<cmd>CMakeRun<cr>', 'run project' },
        },
      },
    }
  end,
}
