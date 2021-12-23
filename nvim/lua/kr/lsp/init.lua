local mapBuf = require("kr.utils.set-key").setBufKey
local nvim_cmp = require("cmp_nvim_lsp")
local lsp = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = nvim_cmp.update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"}
}

local on_attach = function(client, bufnr)
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    mapBuf(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
    mapBuf(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
    mapBuf(bufnr, "n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    mapBuf(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover()<cr>")
    mapBuf(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    mapBuf(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    mapBuf(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>")
    mapBuf(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")

    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
end

vim.lsp.diagnostic.show_line_diagnostics()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    underline = true,
    update_on_insert = true
})

local signs = {
    Error = "ﰸ",
    Warn = "",
    Hint = "",
    Info = ""
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = nil
    })
end

vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]])

return on_attach
