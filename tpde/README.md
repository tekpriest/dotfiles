# TPDE
Currently lazy to write full docs.

## Step 1
Backup your previous nvim folder `mv ~/.config/nvim ~/.config/nvim.bak`  
Clone the repository to your `XDG_CONFIG` directory, it is usually `~/.config` directory using `git clone https://github.com/tekpriest/tpde ~/.config/nvim`

## Step 2
Type `nvim` in your terminal, this config uses [lazy](https://github.com/folke/lazy.nvim) plugin manager, this will auto download plugins  

### Treesitter
Treesitter is set to automatically download packages for any filetype as long as
it is supported

### LSP
The config uses mason to manage lsp - language server protocols. The langs
folder contains the current languages setup, you can copy this to use in your
config as well.

### Formatting
The config currently uses conform and null-ls to manage formatting and linting respectively

### Cleanup
Run `checkhealth` if you are already in neovim or run `nvim +checkhealth` to ensure everything is running correctly

### As a PDE
You can also set up this config as a PDE should you just want to try it out in
which case follow this steps:
- Clone the repo: `git clone https://github.com/tekpriest/tpde ~/.config/pde`
- Run the `bash setup-pde.sh`
Or you can give the folder any name you wish then add  
```bash
export <custom-name>=$HOME/.config/<custom-folder>
echo "alias <custom-name>='NVIM_APPNAME=<custom-name> nvim"
```
 to your bashrc or zshrc file

Made with :heart: tekpriest
