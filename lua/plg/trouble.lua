return {
  'folke/trouble.nvim',
  cmd = { 'Trouble', 'TroubleToggle' },
  config = require('cfg.trouble').config,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
