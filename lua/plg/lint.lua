return {
  'mfussenegger/nvim-lint',
  config = require('cfg.lint').config,
  dependencies = { 'mason-org/mason.nvim' },
  event = { 'BufNewFile', 'BufReadPre' },
}
