return {
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo', 'FormatToggle' },
  config = require('cfg.conform').config,
  dependencies = {
    'williamboman/mason.nvim',
  },
  event = { 'BufWritePre' },
  keys = { '<leader>f', '<leader>F' },
}
