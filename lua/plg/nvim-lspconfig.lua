return {
  'neovim/nvim-lspconfig',
  config = require('cfg.nvim-lspconfig').config,
  event = { 'BufNewFile', 'BufReadPre' },
  priority = 61
}