local vim = _G.vim
local opt,cmd = vim.opt,vim.cmd
local keymap = require('.keymappings')
local function on_attach(_, bufnr)
        opt.omnifunc = "v:lua.vim.lsp.omnifunc"
        keymap({buffer=0}, {
            ["gd"] = vim.lsp.buf.definition,
            ["gr"] = vim.lsp.buf.references,
            ["gs"] = vim.lsp.buf.document_symbol,
            ["[d"] = vim.lsp.diagnostic.goto_prev,
            ["]d"] = vim.lsp.diagnostic.goto_next,
            ["<leader>ca"] = vim.lsp.buf.code_action,
            ["<leader>rn"] = vim.lsp.buf.rename,
            ["<leader>ld"] = vim.lsp.diagnostic.show_line_diagnostics,
        })
        cmd "au BufWritePre * lua vim.lsp.buf.formatting_sync()"
        cmd "au CursorHold,CursorHoldI *.rs,*.c lua vim.lsp.diagnostic.show_line_diagnostics{focusable=false}"
    end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require("lspconfig")
for _,ls in ipairs{"clangd", "rust_analyzer", "tsserver","gopls","jsonls"} do
  lspconfig[ls].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {debounce_text_changes = 150},
  }
end
