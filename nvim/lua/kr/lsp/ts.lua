local caps = require("kr.lsp.utils.capabilities")
local mapBuf = require("kr.utils.set-key").setBufKey
local null = require("null-ls")
local nvim_cmp = require("cmp_nvim_lsp")
local null_sources = require("kr.null")
local on_attach = require("kr.lsp")
local lsp = require 'lspconfig'

lsp.tsserver.setup({
    capabilities = nvim_cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)

        mapBuf(bufnr, "n", "tgs", "<cmd>TSLspOrganize<CR>")
        mapBuf(bufnr, "n", "tgi", "<cmd>TSLspRenameFile<CR>")
        mapBuf(bufnr, "n", "tgo", "<cmd>TSLspImportAll<CR>")

        on_attach(client, bufnr)
    end
})

-- null.setup({
-- sources = null_sources,
-- on_attach = on_attach,
-- })
