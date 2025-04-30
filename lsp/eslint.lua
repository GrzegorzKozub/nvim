return {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = { 'javascript', 'typescript' },
  root_markers = { '.eslintrc*', '.git', 'eslint.config.*', 'package.json' },
  settings = { experimental = {}, nodePath = '' },
}
