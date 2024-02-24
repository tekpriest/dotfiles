---@param path string
---@return string
local function filenameFirst(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == '.' then return tail end
  local parentDisplay = #parent > 25 and vim.fs.basename(parent) or parent
  return string.format('%s\t\t%s', tail, parentDisplay) -- parent colored via autocmd above
end

-- toggle `--hidden` & `--no-ignore` for the `find_files` picker
local function toggleHiddenAndIgnore(prompt_bufnr)
  local current_picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local cwd = tostring(current_picker.cwd or vim.loop.cwd()) -- cwd only set if passed as opt

  -- hidden status not stored, but title is, so we determine the previous state via title
  local prevTitle = current_picker.prompt_title
  local ignoreHidden = not prevTitle:find('hidden')

  local title = vim.fs.basename(cwd)
  if ignoreHidden then title = title .. ' (--hidden --no-ignore)' end
  local currentQuery = require('telescope.actions.state').get_current_line()
  local existingFileIgnores = require('telescope.config').values.file_ignore_patterns or {}

  require('telescope.actions').close(prompt_bufnr)
  require('telescope.builtin').find_files {
    default_text = currentQuery,
    prompt_title = title,
    hidden = ignoreHidden,
    no_ignore = ignoreHidden,
    cwd = cwd,
    -- prevent these becoming visible through `--no-ignore`
    file_ignore_patterns = {
      'node_modules',
      '.venv',
      '%.DS_Store$',
      '%.git/',
      '%.app/',
      unpack(existingFileIgnores), -- must be last for all items to be unpacked
    },
  }
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = { { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
  cmd = 'Telescope',
  opts = {
    defaults = {
      -- path_display = { 'tail' },
      results_title = false,
      dynamic_preview_title = true,
      preview = { timeout = 400, filesize_limit = 1 }, -- ms & Mb
      borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      layout_strategy = 'horizontal',
      sorting_strategy = 'ascending', -- so layout is consistent with prompt_position "top"
      -- layout_config = {
      --   horizontal = {
      --     prompt_position = 'top',
      --     height = { 0.75, min = 13 },
      --     width = 0.99,
      --     preview_cutoff = 70,
      --     preview_width = { 0.55, min = 30 },
      --   },
      --   vertical = {
      --     prompt_position = 'top',
      --     mirror = true,
      --     height = 0.9,
      --     width = 0.7,
      --     preview_cutoff = 12,
      --     preview_height = { 0.4, min = 10 },
      --     anchor = 'S',
      --   },
      -- },
      -- vimgrep_arguments = {
      --   'rg',
      --   '--vimgrep',
      --   '--smart-case',
      --   '--trim',
      --   -- inherit global ignore file from `fd`
      --   ('--ignore-file=' .. os.getenv('HOME') .. '/.config/fd/ignore'),
      --   '.',
      -- },
      file_ignore_patterns = { '%.png$', '%.svg', '%.gif', '%.zip' },
      mappings = {
        n = {
          ['q'] = function(...) require('telescope.actions').close(...) end,
        },
      },
    },
    find_files = {
      prompt_prefix = '󰝰 ',
      -- path_display = filenameFirst,
      -- prioritze recently modified
      tiebreak = function(a, b, _)
        local a_stats = vim.loop.fs_stat(a.ordinal)
        local b_stats = vim.loop.fs_stat(b.ordinal)
        if not (a_stats and b_stats) then return false end
        return a_stats.mtime.sec > b_stats.mtime.sec
      end,
      -- FIX using the default fd command from telescope is somewhat buggy,
      -- e.g. not respecting `~/.config/fd/ignore`
      find_command = { 'fd', '--type=file', '--type=symlink' },
      mappings = {
        i = {
          ['<C-h>'] = toggleHiddenAndIgnore,
          -- automatically toggle hidden files when entering `.`
          ['.'] = function(prompt_bufnr)
            vim.api.nvim_feedkeys('.', 'n', true)
            toggleHiddenAndIgnore(prompt_bufnr)
          end,
        },
      },
      follow = false,
    },
    -- live_grep = {
    --   prompt_prefix = ' ',
    --   disable_coordinates = true,
    --   layout_config = { horizontal = { preview_width = 0.7 } },
    -- },
  },
  config = function(_, opts)
    local telescope = require('telescope')
    telescope.setup(opts)
    telescope.load_extension('fzf')
    telescope.load_extension('harpoon')
  end,
  init = function()
    -- color parent as comment
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'TelescopeResults',
      callback = function(ctx)
        vim.api.nvim_buf_call(ctx.buf, function() vim.fn.matchadd('Comment', '\t\t.*$') end)
      end,
    })
  end,
  keys = {
    { '<leader><space>', '<cmd>Telescope find_files<cr>', desc = 'find files' },
    {
      '<leader>fw',
      '<cmd>Telescope live_grep<cr>',
      desc = 'live text search',
    },
    { '<leader>fb',      '<cmd>Telescope buffers<cr>',    desc = 'list buffers' },
    { '<leader>ff',      '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
    { '<leader>fg',      '<cmd>Telescope git_files<cr>',  desc = 'Git Files' },
  },
}
