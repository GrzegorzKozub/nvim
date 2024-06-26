return {
  'nvim-telescope/telescope.nvim',
  cmd = { 'Telescope' },
  config = require('cfg.telescope').config,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  keys = { '<c-b>', '<c-p>', '<c-k>', '<c-g>' },
}
