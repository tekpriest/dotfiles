local lsp = require("lspconfig")
local cap = require("kr.lsp.utils.capabilities")
local on_attach = require("kr.lsp")
local sumneko_path = os.getenv("HOME") .. "/.local/bin/lua-language-server"
local sumneko_bin = sumneko_path .. "/bin/macOS/lua-language-server"

lsp.sumneko_lua.setup({
    capabilities = cap,
    on_attach = on_attach,
    cmd = {sumneko_bin, "-E", sumneko_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";")
            },
            completion = {
                enable = true,
                callSnippet = "Both"
            },
            diagnostics = {
                enable = true,
                globals = {"vim"},
                disable = {"lowercase-global"}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                },
                maxPreload = 2000,
                preloadFileSize = 1000
            }
        }
    }
})
