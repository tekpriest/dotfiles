return {
	'https://github.com/windwp/nvim-autopairs',
	opts = {
		disable_filetype = { 'TelescopePrompt', 'guihua', 'guihua_rust', 'clap_input' },
		autopairs = { enable = true },
		ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''), -- "[%w%.+-"']",
		enable_check_bracket_line = false,
		html_break_line_filetype = {
			'html',
			'vue',
			'typescriptreact',
			'svelte',
			'javascriptreact',
		},
		check_ts = true,
		ts_config = {
			lua = { 'string' }, -- it will not add pair on that treesitter node
			-- go = {'string'},
			javascript = { 'template_string' },
			java = false, -- don't check treesitter on java
		},
		fast_wrap = {}, -- <M-e> $: add to end; q: move to end; qh (virtual text prompts)
	}
}
-- local npairs = require 'nvim-autopairs'
-- local Rule = require 'nvim-autopairs.rule'

-- npairs.add_rules {
--   Rule(' ', ' '):with_pair(function(opts)
--     local pair = opts.line:sub(opts.col - 1, opts.col)
--     return vim.tbl_contains({ '()', '[]', '{}' }, pair)
--   end),
--   Rule('(', ')'):with_pair(function(opts)
--     return opts.prev_char:match '.%)' ~= nil
--   end):use_key ')',
--   Rule('{', '}'):with_pair(function(opts)
--     return opts.prev_char:match '.%}' ~= nil
--   end):use_key '}',
--   Rule('[', ']'):with_pair(function(opts)
--     return opts.prev_char:match '.%]' ~= nil
--   end):use_key ']',
-- }

-- local ok, ts_conds = pcall(require, 'nvim-autopairs.ts-conds')
-- if ok then
--   -- press % => %% is only inside comment or string
--   npairs.add_rules {
--     Rule('%', '%', 'lua'):with_pair(ts_conds.is_ts_node { 'string', 'comment' }),
--     Rule('$', '$', 'lua'):with_pair(ts_conds.is_not_ts_node { 'function' }),
--   }
-- end
