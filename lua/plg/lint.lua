return {
  'mfussenegger/nvim-lint',
  cond = not vim.g.vscode,
  config = require('cfg.lint').config,
  dependencies = {
    'williamboman/mason.nvim',
  },
  event = { 'BufNewFile', 'BufReadPre' },
}
