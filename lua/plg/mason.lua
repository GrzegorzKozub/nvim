return {
  'williamboman/mason.nvim',
  build = ':MasonUpdate',
  cmd = 'Mason',
  config = require('cfg.mason').config,
}