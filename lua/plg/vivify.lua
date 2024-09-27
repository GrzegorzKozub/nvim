return {
  'jannis-baum/vivify.vim',
  cond = vim.fn.has 'win32' == 0,
  config = require('cfg.vivify').config,
  ft = 'markdown',
}