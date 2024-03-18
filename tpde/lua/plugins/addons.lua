return {
  { -- CodeLens, but also for languages not supporting it
    'Wansmer/symbol-usage.nvim',
    event = 'BufReadPre',
    opts = {
      hl = { link = 'Comment' },
      vt_position = 'end_of_line',
      request_pending_text = false, -- no "Loading…" PENDING https://github.com/Wansmer/symbol-usage.nvim/issues/24
      references = { enabled = true, include_declaration = false },
      definition = { enabled = false },
      implementation = { enabled = false },
      kinds = { -- available kinds: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
        vim.lsp.protocol.SymbolKind.Function,
        vim.lsp.protocol.SymbolKind.Method,
        vim.lsp.protocol.SymbolKind.Object,
      },
      text_format = function(symbol)
        if symbol.references == 0 then return '' end
        -- return ' 󰈿 ' .. symbol.references
        return 'references ' .. symbol.references
      end,
    },
  },
}
