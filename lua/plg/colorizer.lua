return {
  'catgoose/nvim-colorizer.lua',
  config = require('cfg.colorizer').config,
  event = { 'BufNewFile', 'BufReadPre' },
}
