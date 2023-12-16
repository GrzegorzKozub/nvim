return {
  'neovim/nvim-lspconfig',
  config = require('cfg.nvim-lspconfig').config,
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  event = { 'BufNewFile', 'BufReadPre' },
  ft = 'json',
}