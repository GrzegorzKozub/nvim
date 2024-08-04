return {
  'williamboman/mason-lspconfig.nvim',
  cond = not vim.g.vscode,
  config = require('cfg.mason-lspconfig').config,
  dependencies = {
    'williamboman/mason.nvim',
  },
  lazy = true,
}
