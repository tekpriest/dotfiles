return {
  root_dir = function(...)
    -- using a root .clang-format or .clang-tidy file messes up projects, so remove them
    return require('lspconfig.util').root_pattern(
      'compile_commands.json',
      'compile_flags.txt',
      'configure.ac',
      '.git'
    )(...)
  end,
  capabilities = {
    offsetEncoding = { 'utf-16' },
  },
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
    '--function-arg-placeholders',
    '--fallback-style=llvm',
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
}
