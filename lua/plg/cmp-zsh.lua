return {
  'tamago324/cmp-zsh',
  commit = '70ca884',
  cond = vim.fn.has 'win32' == 0,
  config = require('cfg.cmp-zsh').config,
  lazy = true,
}