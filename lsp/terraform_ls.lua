return {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = {
    'terraform',
    'terraform-deploy',
    'terraform-search',
    'terraform-stack',
    'terraform-vars',
  },
  root_markers = { '.git', '.terraform' },
  initialization_options = {
    ['terraform-ls'] = { experimentalFeatures = { prefillRequiredFields = true } },
  },
}
