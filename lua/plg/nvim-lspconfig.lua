return {
  'neovim/nvim-lspconfig',
  config = require('cfg.nvim-lspconfig').config,
  event = require('cfg.need_lsp').events,
  ft = require('cfg.need_lsp').file_types,
  priority = 61,
}