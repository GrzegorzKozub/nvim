return {
  'jay-babu/mason-null-ls.nvim',
  config = require('cfg.mason-null-ls').config,
  dependencies = {
    'williamboman/mason.nvim',
    'nvimtools/none-ls.nvim',
  },
  event = { 'BufNewFile', 'BufReadPre' },
  ft = 'json',
}