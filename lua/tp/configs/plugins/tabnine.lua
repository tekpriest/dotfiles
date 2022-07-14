local tabnine = require("cmp_tabnine.config")
tabnine:setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
	ignore_file_types = { terminal = true, lazygit = true, html = true },
	show_prediction_strength = true,
})
