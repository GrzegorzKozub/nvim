return {
  'rshkarin/mason-nvim-lint',
  config = require('cfg.mason-lint').config,
  dependencies = {
    'williamboman/mason.nvim',
    'mfussenegger/nvim-lint',
  },
  event = { 'BufNewFile', 'BufReadPre' },
  ft = 'json',
}