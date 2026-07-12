return {
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo', 'FormatToggle' },
  config = require('cfg.conform').config,
  dependencies = {
    'mason-org/mason.nvim',
  },
  event = { 'BufWritePre' },
  keys = { '<leader>f', '<leader>F' },
}
