local fn = vim.fn

if vim.fn.isdirectory(vim.o.undodir) == 0 then
	vim.fn.mkdir(vim.o.undodir, "p")
end
if fn.isdirectory(vim.o.directory) == 0 then
  tp.add_config("directory", fn.stdpath("data") .. "/swap//")
	fn.mkdir(vim.o.directory, "p")
end
tp.add_config("guicursor", {
	[[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
	[[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
	[[sm:block-blinkwait175-blinkoff150-blinkon175]],
})
vim.cmd([[colorscheme kanagawa]])

vim.o.switchbuf = "useopen,uselast"
vim.o.grepprg = [[rg --glob "!.git", --no-heading --vimgrep --follow $*]]
tp.add_config("grepformat", vim.opt.grepformat ^ { "%f:%l%c%n" })
tp.add_config("wildcharm", vim.fn.char2nr(tp.replace_termcodes([[<Tab>]])))
tp.add_config("wildignore", {
  "*/cache/*",
  "*/tmp/*",
  "*/node_modules/*",
  "*.aux",
	"*.out",
	"*.toc",
	"*.o",
	"*.obj",
	"*.dll",
	"*.jar",
	"*.pyc",
	"*.rbc",
	"*.class",
	"*.gif",
	"*.ico",
	"*.jpg",
	"*.jpeg",
	"*.png",
	"*.avi",
	"*.wav",
  -- Temp/System
	"*.*~",
	"*~ ",
	"*.swp",
	".lock",
	".DS_Store",
	"tags.lock",
  "*.lock.*"
})
tp.add_config("wildoptions", "pum")
tp.add_config("pumblend", 3)
tp.add_config("synmaxcol", 1024)
tp.add_config("ruler", false)
tp.add_config("conceallevel", 2)
tp.add_config("breakindentopt", "sbr")
tp.add_config("signcolumn", "yes:1")
tp.add_config("cmdheight", 2)
vim.g.markdown_fenced_languages = {
  "js=javascript",
  "ts=typescript",
  "shell=sh",
  "bash=sh",
  "console=sh"
}

tp.add_config("joinspaces", false)
tp.add_config("gdefault", true)
tp.add_config("autowriteall", true)
tp.add_config("spelloptions", "camel")
tp.add_config("spellcapcheck", "")
tp.add_config("fileformats", { "unix", "mac", "dos" })
tp.add_config("mousefocus", true)
tp.add_config("secure", true)
tp.add_config("exrc", true)

vim.g.mapleader = " "
vim.g.one_allow_italics = true
vim.g.oceanic_next_terminal_bold = true
vim.g.oceanic_next_terminal_italic = true
vim.g.gruvbox_italic = true
vim.g.vim_monokai_tasty_italic = true
vim.g.table_mode_corner = "|"
vim.g.markdown_fold_override_foldtext = false
vim.g.markdown_syntax_conceal = false
vim.g.mkdp_auto_start = false
vim.g.vim_json_syntax_conceal = false
vim.g.override_nvim_web_devicons = true
vim.g.dashboard_default_executive = "telescope"

