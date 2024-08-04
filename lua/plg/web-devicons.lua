return {
  'nvim-tree/nvim-web-devicons',
  cond = not vim.g.vscode,
  config = require('cfg.web-devicons').config,
  lazy = true,
}