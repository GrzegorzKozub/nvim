return {
  'NvChad/nvim-colorizer.lua',
  cond = not vim.g.vscode,
  config = require('cfg.colorizer').config,
  event = { 'BufNewFile', 'BufReadPre' },
}
