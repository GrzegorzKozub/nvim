return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  cmd = 'TSUpdateSync',
  config = require('cfg.treesitter').config,
  dependencies = { 'nushell/tree-sitter-nu' },
  event = { 'BufNewFile', 'BufReadPre' },
}
