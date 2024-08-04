return {
  'folke/trouble.nvim',
  cmd = { 'Trouble' },
  cond = not vim.g.vscode,
  config = require('cfg.trouble').config,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}