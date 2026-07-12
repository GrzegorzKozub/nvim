return {
  'nvim-treesitter/nvim-treesitter',
  cond = vim.fn.has 'win32' == 0,
  build = ':TSUpdate',
  cmd = 'TSUpdate',
  config = require('cfg.treesitter').config,
  event = { 'BufNewFile', 'BufReadPre' },
}
