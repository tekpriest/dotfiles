return {
	{
		'ruifm/gitlinker.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {},
		config = function(_, opts)
			require('gitlinker').setup(opts)
		end,
		keys = {
			{
				'<leader>gy',
				'<cmd>lua require("gitlinker").get_repo_url()<cr>',
				desc = 'copy homepage url',
			},
		},
	},
	{
		'NeogitOrg/neogit',
		dependencies = {
			'nvim-lua/plenary.nvim', -- required
			'sindrets/diffview.nvim', -- optional
			'folke/snacks.nvim',
		},
		config = true,
		keys = {
			{ '<leader>gg', '<cmd>Neogit cwd=%:p:h<cr>', desc = 'Git Status' },
			{ '<leader>gc', '<cmd>Neogit commit<cr>',    desc = 'Git Status' },
		},
	},
	{
		'lewis6991/gitsigns.nvim',
		ft = { 'gitcommit', 'diff' },
		init = function()
			-- load gitsigns only when a git file is opened
			vim.api.nvim_create_autocmd({ 'BufRead' }, {
				group = vim.api.nvim_create_augroup('GitSignsLazyLoad', { clear = true }),
				callback = function()
					vim.fn.system('git -C ' .. '"' .. vim.fn.expand '%:p:h' .. '"' .. ' rev-parse')
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name 'GitSignsLazyLoad'
						vim.schedule(function()
							require('lazy').load { plugins = { 'gitsigns.nvim' } }
							-- vim.cmd [[Gitsigns toggle_current_line_blame]]
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
			{
				'<leader>gb',
				'<cmd>Gitsigns blame_line<cr>',
				desc = 'blame line',
			},
		},
		config = true,
	}
}
