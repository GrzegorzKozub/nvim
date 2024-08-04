return {
  'lewis6991/gitsigns.nvim',
  cond = not vim.g.vscode,
  config = require('cfg.gitsigns').config,
  event = { 'BufNewFile', 'BufReadPre' },
}
