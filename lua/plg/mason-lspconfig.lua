return {
  'williamboman/mason-lspconfig.nvim',
  config = require('cfg.mason-lspconfig').config,
  dependencies = {
    'williamboman/mason.nvim',
  },
  event = { 'BufNewFile', 'BufReadPre' },
  ft = 'json',
}