return {
  'sainnhe/gruvbox-material',
  cond = not vim.g.vscode,
  config = require('cfg.gruvbox-material').config,
  priority = 71,
}
