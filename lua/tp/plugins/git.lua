return {
  'lewis6991/gitsigns.nvim',
  ft = { 'gitcommit', 'diff' },
  init = function()
    -- load gitsigns only when a git file is opened
    vim.api.nvim_create_autocmd({ 'BufRead' }, {
      group = vim.api.nvim_create_augroup('GitSignsLazyLoad', { clear = true }),
      callback = function()
        vim.fn.system(
          'git -C ' .. '"' .. vim.fn.expand '%:p:h' .. '"' .. ' rev-parse'
        )
        if vim.v.shell_error == 0 then
          vim.api.nvim_del_augroup_by_name 'GitSignsLazyLoad'
          vim.schedule(function()
            require('lazy').load { plugins = { 'gitsigns.nvim' } }
            vim.cmd [[Gitsigns toggle_current_line_blame]]
          end)
        end
      end,
    })
  end,
  keys = {
    {
      ']g',
      '<cmd>Gitsigns next_hunk<cr>',
      desc = 'next hunk',
    },
    {
      '[g',
      '<cmd>Gitsigns prev_hunk<cr>',
      desc = 'previous hunk',
    },
    {
      '<leader>ga',
      '<cmd>Gitsigns stage_hunk<cr>',
      desc = 'stage hunk',
    },
    {
      '<leader>gr',
      '<cmd>Gitsigns reset_hunk<cr>',
      desc = 'reset hunk',
    },
    {
      '<leader>gu',
      '<cmd>Gitsigns undo_stage_hunk<cr>',
      desc = 'undo stage hunk',
    },
    {
      '<leader>gp',
      '<cmd>Gitsigns preview_hunk<cr>',
      desc = 'preview hunk changes',
    },
  },
  config = true,
  -- config = function()
  --   require('gitsigns').setup()
  -- end,
}
