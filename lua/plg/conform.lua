return {
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo' },
  cond = not vim.g.vscode,
  config = require('cfg.conform').config,
  dependencies = {
    'williamboman/mason.nvim',
  },
  keys = { '<leader>f' },
}
