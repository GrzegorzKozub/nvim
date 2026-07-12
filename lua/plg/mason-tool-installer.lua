return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  cmd = { 'MasonToolsClean', 'MasonToolsInstall', 'MasonToolsUpdate' },
  config = require('cfg.mason-tool-installer').config,
  dependencies = { 'mason-org/mason.nvim' },
}
