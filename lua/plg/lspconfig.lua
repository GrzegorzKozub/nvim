return {
  'neovim/nvim-lspconfig',
  cmd = 'LspInfo',
  config = require('cfg.lspconfig').config,
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  event = { 'BufNewFile', 'BufReadPre' },
}