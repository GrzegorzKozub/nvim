return {
  'mfussenegger/nvim-lint',
  config = require('cfg.lint').config,
  event = { 'BufNewFile', 'BufReadPre' },
  ft = 'json',
}