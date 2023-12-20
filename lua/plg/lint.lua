return {
  'mfussenegger/nvim-lint',
  config = require('cfg.lint').config,
  dependencies = {
    'williamboman/mason.nvim',
  },
  event = { 'BufNewFile', 'BufReadPre' },
  ft = 'json',
}