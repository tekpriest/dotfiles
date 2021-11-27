Plug 'folke/which-key.nvim'

function WhichKeySetup()
lua << EOF
require("which-key").setup({
        \ ['e'] = [':NERDTreeToggle', 'explorer']
        \ },{prefix = '\<Space>'})
EOF
endfunction

augroup WhichKeySetup
    autocmd!
    autocmd User PlugLoaded call WhichKeySetup()
augroup END
