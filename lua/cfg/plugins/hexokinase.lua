return {
  'rrethy/vim-hexokinase',
  build = 'make hexokinase',
  config = require('cfg.hexokinase').config,
  event = { 'BufNewFile', 'BufReadPre' },
}