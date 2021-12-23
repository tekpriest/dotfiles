local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

return require("packer").startup({
    function(use)
        -- Packer can manage itself as an optional plugin
        use({"nvim-lua/popup.nvim"})
        use({"nvim-lua/plenary.nvim"})
        use({"wbthomason/packer.nvim"})
        use({"tpope/vim-unimpaired"})
        use({"christoomey/vim-tmux-navigator"})
        use({"tpope/vim-surround"})
        use({
            "terrortylor/nvim-comment",
            config = function()
                require("nvim_comment").setup({
                    hook = function()
                        require("ts_context_commentstring.internal").update_commentstring()
                    end
                })
            end
        })
        use({"JoosepAlviste/nvim-ts-context-commentstring"})

        use({"junegunn/vim-easy-align"})
        use({"ojroques/nvim-bufdel"})
        use({"kyazdani42/nvim-tree.lua"})
        use({
            "hoob3rt/lualine.nvim",
            requires = {
                'kyazdani42/nvim-web-devicons',
                opt = true
            }
        })
        use({
            "akinsho/bufferline.nvim",
            config = function()
                require("bufferline").setup({
                    options = {
                        numbrs = "none",
                        tab_size = 10,
                        diagnostics = "nvim_lsp"
                    }
                })
            end
        })

        -- Colors
        use({"morhetz/gruvbox"})

        -- Editor Config
        use({"editorconfig/editorconfig-vim"})

        -- Git
        use({"tpope/vim-fugitive"})
        -- use {"tpope/vim-rhubarb"}
        -- use {"sgeb/vim-diff-fold"}
        use({
            "lewis6991/gitsigns.nvim",
            requires = {"nvim-lua/plenary.nvim"},
            event = "BufReadPre",
            config = function()
                require("gitsigns").setup({
                    debug_mode = false,
                    signs = {
                        add = {
                            hl = "GitGutterAdd",
                            text = "│"
                        },
                        change = {
                            hl = "GitGutterChange",
                            text = "│"
                        },
                        delete = {
                            hl = "GitGutterDelete",
                            text = "_"
                        },
                        topdelete = {
                            hl = "GitGutterDelete",
                            text = "‾"
                        },
                        changedelete = {
                            hl = "GitGutterChangeDelete",
                            text = "~"
                        }
                    }
                })
            end
        })
        use({"p00f/nvim-ts-rainbow"})
        use({"pwntester/octo.nvim"})
        -- use {"TimUntersberger/neogit"}
        use({"sheerun/vim-polyglot"})

        -- -- Markdown
        use({
            "tpope/vim-markdown",
            ft = "markdown"
        })
        -- use {"rhysd/vim-grammarous"}
        -- use {"nelstrom/vim-markdown-folding", ft = "markdown"}
        use({"dhruvasagar/vim-table-mode"})
        use({
            "iamcco/markdown-preview.nvim",
            run = "cd app && yarn install"
        })
        -- Rust
        -- use {"rust-lang/rust.vim"}
        -- use {"racer-rust/vim-racer"}
        -- Python
        --	use({ "tmhedberg/SimpylFold", ft = "python" })
        -- JS/TS
        -- use {"othree/yajs.vim"}
        -- use {"MaxMEllon/vim-jsx-pretty"}
        use({"heavenshell/vim-jsdoc"})
        -- use {"elzr/vim-json"}
        -- use {"neoclide/jsonc.vim"}
        use({"HerringtonDarkholme/yats.vim"})
        -- use {"Quramy/vison"}
        -- use {"jxnblk/vim-mdx-js"}
        -- HTML
        -- use {"othree/html5.vim"}
        -- use {"mattn/emmet-vim"}
        --    use {"posva/vim-vue"}
        -- use {"leafOfTree/vim-svelte-plugin"}
        --    use {"skwp/vim-html-escape"}
        --    use {"kana/vim-textobj-user"}
        --    use {"whatyouhide/vim-textobj-xmlattr"}
        --    use {"pedrohdz/vim-yaml-folds"}
        -- CSS
        --  use {"hail2u/vim-css3-syntax"}
        use({
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("colorizer").setup({})
            end
        })

        -- Swift
        -- use {"keith/swift.vim"}
        --    use {"gfontenot/vim-xcode"}
        -- Reason
        -- use{ "reasonml-editor/vim-reason-plus" }
        -- Go
        use {"fatih/vim-go"}
        -- Lua
        use({"tbastos/vim-lua"})

        use({"mhartington/formatter.nvim"})
        use({"mhartington/oceanic-next"})

        use({
            "nvim-treesitter/nvim-treesitter",
            run = ':TSUpdate'
        })
        use({"nvim-treesitter/nvim-treesitter-textobjects"})
        use({"nvim-treesitter/playground"})

        use({"neovim/nvim-lspconfig"})
        use({"glepnir/lspsaga.nvim"})
        use({
            "folke/trouble.nvim",
            config = function()
                require("trouble").setup({})
            end
        })
        use({"jose-elias-alvarez/null-ls.nvim"})
        use({"jose-elias-alvarez/nvim-lsp-ts-utils"})

        -- autocomplete
        use("neovim/nvim-lspconfig")
        use({
            "hrsh7th/nvim-cmp",
            requires = {{"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-nvim-lua"}, {"hrsh7th/cmp-buffer"},
                        {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-cmdline"}, {"hrsh7th/vim-vsnip"}, {"hrsh7th/cmp-vsnip"},
                        {"hrsh7th/vim-vsnip-integ"}, {"f3fora/cmp-spell", {"hrsh7th/cmp-calc"}, {"hrsh7th/cmp-emoji"}}}
        })

        use({
            "nvim-telescope/telescope.nvim",
            module = "telescope",
            cmd = "Telescope",
            requires = {{
                "nvim-telescope/telescope-fzy-native.nvim",
                run = "make"
            }, {"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
        })
        use({"nvim-telescope/telescope-file-browser.nvim"})
        use({
            "onsails/lspkind-nvim",
            requires = {{"famiu/bufdelete.nvim"}}
        })

        use({"kyazdani42/nvim-web-devicons"})
        use({"mjlbach/neovim-ui"})

        use({"dstein64/vim-startuptime"})

        use({
            "windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = function()
                require("nvim-autopairs").setup({})
            end
        })

        use({"goolord/alpha-nvim"})
        use({"glepnir/dashboard-nvim"})
        use({"wakatime/vim-wakatime"})
        use({"folke/which-key.nvim"})
        use({
            "Shatur/neovim-session-manager",
            config = function()
                require('session_manager').setup {
                    autoload_mode = "Diabled"
                }
            end
        })
        use({"windwp/nvim-ts-autotag"})
        use({
            "simrat39/symbols-outline.nvim",
            cmd = {"SymbolsOutline"}
        })

        use({
            "numToStr/Comment.nvim",
            opt = true,
            keys = {"gc", "gcc"},
            config = function()
                require('Coment').setup {}
            end
        })

    end,
    config = {
        display = {
            open_fn = require("packer.util").float
        },
        profile = {
            enable = true,
            threshold = 1
        }
    }
})
