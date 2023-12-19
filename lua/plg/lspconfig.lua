return {
  'neovim/nvim-lspconfig',
  config = require('cfg.lspconfig').config,
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  event = { 'BufNewFile', 'BufReadPre' },
  ft = 'json',
}