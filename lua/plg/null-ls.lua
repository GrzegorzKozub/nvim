return {
  'jose-elias-alvarez/null-ls.nvim',
  config = require('cfg.null-ls').config,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = require('cfg.need_lsp').events,
  ft = require('cfg.need_lsp').file_types,
}