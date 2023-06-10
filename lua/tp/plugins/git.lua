return {
  {
    'lewis6991/gitsigns.nvim',
    ft = { 'gitcommit', 'diff' },
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ 'BufRead' }, {
        group = vim.api.nvim_create_augroup(
          'GitSignsLazyLoad',
          { clear = true }
        ),
        callback = function()
          vim.fn.system(
            'git -C ' .. '"' .. vim.fn.expand '%:p:h' .. '"' .. ' rev-parse'
          )
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name 'GitSignsLazyLoad'
            vim.schedule(function()
              require('lazy').load { plugins = { 'gitsigns.nvim' } }
            end)
          end
        end,
      })
    end,
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { hl = 'DiffAdd', text = '│', numhl = 'GitSignsAddNr' },
          change = {
            hl = 'DiffChange',
            text = '│',
            numhl = 'GitSignsChangeNr',
          },
          delete = {
            hl = 'DiffDelete',
            text = '󰍵',
            numhl = 'GitSignsDeleteNr',
          },
          topdelete = {
            hl = 'DiffDelete',
            text = '‾',
            numhl = 'GitSignsDeleteNr',
          },
          changedelete = {
            hl = 'DiffChangeDelete',
            text = '~',
            numhl = 'GitSignsChangeNr',
          },
          untracked = {
            hl = 'GitSignsAdd',
            text = '│',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn',
          },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map('n', '<leader>hb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function()
            gs.diffthis '~'
          end)
          map('n', '<leader>hd', gs.toggle_deleted)
        end,
      }
    end,
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = { 'LazyGit', 'LazyGitConfig' },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}
