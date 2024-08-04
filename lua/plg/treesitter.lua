return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  cmd = 'TSUpdateSync',
  cond = not vim.g.vscode,
  config = require('cfg.treesitter').config,
  dependencies = { 'nushell/tree-sitter-nu' },
  event = { 'BufNewFile', 'BufReadPre' },
}