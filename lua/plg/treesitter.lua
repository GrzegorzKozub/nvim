return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  cmd = 'TSUpdateSync',
  config = require('cfg.treesitter').config,
  event = { 'BufNewFile', 'BufReadPre' },
  ft = 'json',
}