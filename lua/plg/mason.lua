return {
  'mason-org/mason.nvim',
  build = ':MasonUpdate',
  cmd = 'Mason',
  event = { 'BufNewFile', 'BufReadPre' },
  config = require('cfg.mason').config,
}
