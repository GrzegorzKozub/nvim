return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  cmd = { 'MasonToolsClean', 'MasonToolsInstall', 'MasonToolsUpdate' },
  cond = not vim.g.vscode,
  config = require('cfg.mason-tool-installer').config,
  dependencies = {
    'williamboman/mason.nvim',
  },
}