return {
  'nvim-treesitter/nvim-treesitter-context',
  config = require('cfg.treesitter-context').config,
  event = { 'BufNewFile', 'BufReadPre' },
}
