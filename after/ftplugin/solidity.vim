let g:prettier#exec_cmd_path = '~/.local/share/nvim/site/pack/packer/opt/vim-prettier/node_modules/.bin/prettier'
let g:prettier#autoformat = 0
autocmd BufWritePre *.sol Prettier

