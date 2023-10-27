return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  cmd = 'TSUpdateSync',
  config = require('cfg.treesitter').config,
  event = require('cfg.need_lsp').events,
  ft = require('cfg.need_lsp').file_types,
}