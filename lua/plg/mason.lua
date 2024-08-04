return {
  'williamboman/mason.nvim',
  build = ':MasonUpdate',
  cond = not vim.g.vscode,
  cmd = 'Mason',
  config = require('cfg.mason').config,
}
