return {
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo' },
  config = require('cfg.conform').config,
  event = { 'BufNewFile', 'BufReadPre' },
  ft = 'json',
}