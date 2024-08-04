return {
  'jannis-baum/vivify.vim',
  cond = not vim.g.vscode,
  config = require('cfg.vivify').config,
  ft = 'markdown',
}