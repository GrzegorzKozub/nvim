return {
  'nvim-treesitter/nvim-treesitter-context',
  cond = vim.fn.has 'win32' == 0,
  config = require('cfg.treesitter-context').config,
  event = { 'BufNewFile', 'BufReadPre' },
}
