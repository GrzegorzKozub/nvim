return {
  'tamago324/cmp-zsh',
  commit = '70ca884eb90a7a6d9f36665042f273ed3d475438',
  cond = not vim.g.vscode and vim.fn.has 'win32' == 0,
  config = require('cfg.cmp-zsh').config,
  lazy = true,
}