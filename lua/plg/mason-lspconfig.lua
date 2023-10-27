return {
  'williamboman/mason-lspconfig.nvim',
  config = require('cfg.mason-lspconfig').config,
  dependencies = {
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
  },
  event = require('cfg.need_lsp').events,
  ft = require('cfg.need_lsp').file_types,
}