return {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Both',
        workspaceWord = true,
      },
      diagnostics = {
        enable = true,
        globals = { 'vim' },
      },
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
    },
    diagnostics = {
      groupSeverity = {
        strong = 'Warning',
        strict = 'Warning',
      },
      groupFileStatus = {
        ['ambiguity'] = 'Opened',
        ['await'] = 'Opened',
        ['codestyle'] = 'None',
        ['duplicate'] = 'Opened',
        ['global'] = 'Opened',
        ['luadoc'] = 'Opened',
        ['redefined'] = 'Opened',
        ['strict'] = 'Opened',
        ['strong'] = 'Opened',
        ['type-check'] = 'Opened',
        ['unbalanced'] = 'Opened',
        ['unused'] = 'Opened',
      },
      unusedLocalExclude = { '_*' },
    },
  },
}
