return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { '.git', 'pyproject.toml', 'pyrightconfig.json', 'requirements.txt' },
  settings = { basedpyright = {} },
}
