return {
  'grzegorzkozub/gitsigns.nvim', -- 'lewis6991/gitsigns.nvim',
  config = require('cfg.gitsigns').config,
  event = { 'BufNewFile', 'BufReadPre' },
}
