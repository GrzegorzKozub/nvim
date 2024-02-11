return {
  'tamago324/cmp-zsh',
  cond = vim.fn.has 'win32' == 0,
  config = require('cfg.cmp-zsh').config,
  lazy = true,
}
