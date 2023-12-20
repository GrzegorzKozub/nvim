return {
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo' },
  config = require('cfg.conform').config,
  dependencies = {
    'williamboman/mason.nvim',
  },
  event = { 'BufNewFile', 'BufReadPre' },
  ft = 'json',
}
