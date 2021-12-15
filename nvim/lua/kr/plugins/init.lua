local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

return require'packer'.startup(
function(use)
    -- Packer can manage itself as an optional plugin
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"wbthomason/packer.nvim"}
    use {"Raimondi/delimitMate"}
    use {"tpope/vim-unimpaired"}
    use {"AndrewRadev/switch.vim"}
    use {"tpope/vim-surround"}
    use {
      "terrortylor/nvim-comment",
      config = function()
        require("nvim_comment").setup(
          {
            hook = function()
              require('ts_context_commentstring.internal').update_commentstring()
            end
          }
        )
      end
    }
    use {"JoosepAlviste/nvim-ts-context-commentstring"}

    use {"junegunn/vim-easy-align"}
    use {"mhinz/vim-sayonara"}
    use {"ojroques/nvim-bufdel"}
    use {"mg979/vim-visual-multi"}
    use {"yukimemi/dps-asyngrep"}
    use {"Xuyuanp/yanil"}
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        vim.g.indent_blankline_buftype_exclude = {"terminal"}
        vim.g.indent_blankline_filetype_exclude = {"help", "startify", "dashboard", "packer", "Yanil"}
        vim.g.indent_blankline_char = "?"
        vim.g.indent_blankline_use_treesitter = false
        vim.g.indent_blankline_show_current_context = false
        vim.g.indent_blankline_show_trailing_blankline_indent = false
      end
    }
    use {"hoob3rt/lualine.nvim"}
    use {"akinsho/nvim-bufferline.lua"}

    -- Colors
    use {"morhetz/gruvbox"}
    use {"patstockwell/vim-monokai-tasty"}
    use {"TroyFletcher/vim-colors-synthwave"}
    use {"bluz71/vim-nightfly-guicolors"}

    -- Editor Config
    use {"editorconfig/editorconfig-vim"}

    -- Git
    use {"tpope/vim-fugitive"}
    use {"tpope/vim-rhubarb"}
    use {"sgeb/vim-diff-fold"}
    use {
      "lewis6991/gitsigns.nvim",
      config = function()
        require "gitsigns".setup {
          debug_mode = false,
          signs = {
            add = {hl = "GitGutterAdd", text = "?"},
            change = {hl = "GitGutterChange", text = "?"},
            delete = {hl = "GitGutterDelete", text = "_"},
            topdelete = {hl = "GitGutterDelete", text = "?"},
            changedelete = {hl = "GitGutterChangeDelete", text = "~"}
          }
        }
      end
    }
    use {"pwntester/octo.nvim"}
    -- use {"TimUntersberger/neogit"}

    -- -- Markdown
    use {"tpope/vim-markdown", ft = "markdown"}
    use {"rhysd/vim-grammarous"}
    use {"nelstrom/vim-markdown-folding", ft = "markdown"}
    use {"dhruvasagar/vim-table-mode"}
    use {
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install"
    }
    -- Rust
    -- use {"rust-lang/rust.vim"}
    -- use {"racer-rust/vim-racer"}
    -- Python
    use {"tmhedberg/SimpylFold", ft = "python"}
    -- JS/TS
    use {"othree/yajs.vim"}
    use {"MaxMEllon/vim-jsx-pretty"}
    use {"heavenshell/vim-jsdoc"}
    use {"elzr/vim-json"}
    use {"neoclide/jsonc.vim"}
    use {"HerringtonDarkholme/yats.vim"}
    use {"Quramy/vison"}
    use {"jxnblk/vim-mdx-js"}
    -- HTML
    use {"othree/html5.vim"}
    use {"mattn/emmet-vim"}
    use {"posva/vim-vue"}
    use {"leafOfTree/vim-svelte-plugin"}
    use {"skwp/vim-html-escape"}
    use {"kana/vim-textobj-user"}
    use {"whatyouhide/vim-textobj-xmlattr"}
    use {"pedrohdz/vim-yaml-folds"}
    -- CSS
    use {"hail2u/vim-css3-syntax"}
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require "colorizer".setup()
      end
    }
    -- Swift
    -- use {"keith/swift.vim"}
    -- use {"gfontenot/vim-xcode"}
    -- Reason
    -- use{ "reasonml-editor/vim-reason-plus" }
    -- Go
    use{ "fatih/vim-go" }
    -- Lua
    use {"tbastos/vim-lua"}

    use {"mhartington/formatter.nvim"}
    use {"mhartington/vim-folds"}
    use {"mhartington/oceanic-next"}

    use {"nvim-treesitter/nvim-treesitter"}
    --use {"nvim-treesitter/nvim-treesitter-angular"}
    use {"nvim-treesitter/playground"}

    use {"hrsh7th/nvim-compe"}
    use {"neovim/nvim-lspconfig"}
    use {"tami5/lspsaga.nvim"}
    use {'williamboman/nvim-lsp-installer'}
    --
    use {"nvim-telescope/telescope.nvim"}
    use {"nvim-telescope/telescope-github.nvim"}
    use {"nvim-telescope/telescope-packer.nvim"}
    use {"nvim-telescope/telescope-node-modules.nvim"}
    use {"nvim-telescope/telescope-fzy-native.nvim"}

    use {"kyazdani42/nvim-web-devicons"}
    -- use {"yamatsum/nvim-nonicons"}
    use {"mjlbach/neovim-ui"}

    use {"dstein64/vim-startuptime"}
  end
)
