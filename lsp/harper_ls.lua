return {
  cmd = { 'harper-ls', '--stdio' },
  filetypes = { 'markdown' },
  root_markers = { '.git' },
  settings = { ['harper-ls'] = { linters = { SpellCheck = false } } },
}
