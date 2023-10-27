return {
  'neovim/nvim-lspconfig',
  config = require('cfg.nvim-lspconfig').config,
  event = { 'BufNewFile', 'BufReadPre' },
  ft = 'json',
  priority = 61,
}