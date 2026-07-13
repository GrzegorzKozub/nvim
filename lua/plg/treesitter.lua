return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  cmd = 'TSUpdate',
  config = require('cfg.treesitter').config,
  event = { 'BufNewFile', 'BufReadPre' },
}
