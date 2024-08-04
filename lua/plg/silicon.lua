return {
  'michaelrommel/nvim-silicon',
  cmd = 'Silicon',
  cond = not vim.g.vscode,
  config = require('cfg.silicon').config,
}