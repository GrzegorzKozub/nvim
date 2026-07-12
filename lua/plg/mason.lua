return {
  'mason-org/mason.nvim',
  build = ':MasonUpdate',
  cmd = 'Mason',
  config = require('cfg.mason').config,
}