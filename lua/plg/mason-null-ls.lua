return {
  'jay-babu/mason-null-ls.nvim',
  config = require('cfg.mason-null-ls').config,
  dependencies = {
    'williamboman/mason.nvim',
    'jose-elias-alvarez/null-ls.nvim',
  },
  event = require('cfg.need_lsp').events,
  ft = require('cfg.need_lsp').file_types,
}