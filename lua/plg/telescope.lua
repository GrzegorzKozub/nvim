return {
  'nvim-telescope/telescope.nvim',
  config = require('cfg.telescope').config,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = { '<c-b>', '<c-p>', '<c-k>', '<c-g>' },
}