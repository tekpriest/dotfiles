local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end
vim.api.nvim_command("packadd packer.nvim")

return require("packer").startup({
  function(use)
    -- Packer can manage itself as an optional plugin
    use({ "nvim-lua/popup.nvim" })
    use({ "nvim-lua/plenary.nvim" })
    use({ "wbthomason/packer.nvim" })
    use({ "tpope/vim-unimpaired" })
    use({ "christoomey/vim-tmux-navigator" })
    use({ "tpope/vim-surround" })
    use({
      "terrortylor/nvim-comment",
      config = function()
        require("nvim_comment").setup({
          hook = function()
            require("ts_context_commentstring.internal").update_commentstring()
          end,
        })
      end,
    })
    use({ "JoosepAlviste/nvim-ts-context-commentstring" })

    use({ "junegunn/vim-easy-align" })
    use({ "ojroques/nvim-bufdel" })
    use({ "kyazdani42/nvim-tree.lua" })
    use({
      "hoob3rt/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
        opt = true,
      },
    })
    use({
      "akinsho/bufferline.nvim",
      config = function()
        require("bufferline").setup({
          options = {
            numbrs = "none",
            tab_size = 10,
            diagnostics = "nvim_lsp",
          },
        })
      end,
    })

    -- Colors
    use({ "morhetz/gruvbox" })

    -- Editor Config
    use({ "editorconfig/editorconfig-vim" })

    -- Git
    use({ "tpope/vim-fugitive" })
    -- use {"tpope/vim-rhubarb"}
    -- use {"sgeb/vim-diff-fold"}
    use({
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("gitsigns").setup({
          numhl = true,
          signcolumn = false,
        })
      end,
    })
    use({ "sheerun/vim-polyglot" })

    -- -- Markdown
    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install",
    })
    use({ "HerringtonDarkholme/yats.vim" })
    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({})
      end,
    })

    -- Go
    use({ "fatih/vim-go" })
    -- Prisma
    use({ "pantharshit00/vim-prisma" })

    use({ "mhartington/oceanic-next" })

    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    })
    use({ "nvim-treesitter/nvim-treesitter-textobjects" })
    use({ "nvim-treesitter/playground" })
    use({ "p00f/nvim-ts-rainbow" })
    use({
      "romgrk/nvim-treesitter-context",
      config = function()
        require("treesitter-context.config").setup({ enable = true })
      end,
    })
    use({ "neovim/nvim-lspconfig" })
    use({ "glepnir/lspsaga.nvim" })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })

    -- autocomplete
    use("neovim/nvim-lspconfig")
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/vim-vsnip" },
        { "hrsh7th/cmp-vsnip" },
        { "hrsh7th/vim-vsnip-integ" },
        { "f3fora/cmp-spell", { "hrsh7th/cmp-calc" }, { "hrsh7th/cmp-emoji" } },
      },
    })

    use({
      "nvim-telescope/telescope.nvim",
      --cmd = "Telescope",
      requires = {
        {
          "nvim-telescope/telescope-fzy-native.nvim",
          run = "make",
        },
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
      },
    })
    use({ "nvim-telescope/telescope-file-browser.nvim" })
    use({
      "onsails/lspkind-nvim",
      requires = { { "famiu/bufdelete.nvim" } },
    })

    use({ "kyazdani42/nvim-web-devicons" })
    use({ "mjlbach/neovim-ui" })

    use({ "dstein64/vim-startuptime" })

    use({
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
        require("nvim-autopairs").setup({})
      end,
    })

    use({ "goolord/alpha-nvim" })
    use({ "glepnir/dashboard-nvim" })
    use({ "wakatime/vim-wakatime" })
    use({ "folke/which-key.nvim" })
    use({
      "Shatur/neovim-session-manager",
      config = function()
        require("session_manager").setup({
          autoload_mode = "Diabled",
        })
      end,
    })
    use({
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup({ enable = true })
      end,
    })
    use({
      "simrat39/symbols-outline.nvim",
      cmd = { "SymbolsOutline" },
    })
    use({
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup({})
      end,
    })

    use({
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup({
          window = {
            width = 0.100,
          },
          plugins = {
            twilight = { enabled = true },
          },
        })
      end,
    })

    -- Orgmode
    use({
      "nvim-orgmode/orgmode",
      config = function()
        require("orgmode").setup({
          org_agenda_files = { "~/Code/org/*", "~/agendas/**/*" },
          org_default_notes_files = "~/Code/org/refile.org",
        })
      end,
    })

    if packer_bootstrap then
      require("packer").sync()
    end
  end,

  config = {
    display = {
      open_fn = require("packer.util").float,
    },
    profile = {
      enable = true,
      threshold = 1,
    },
  },
})
