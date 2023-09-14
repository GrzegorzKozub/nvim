return {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  cmd = 'Neorg',
  config = require('cfg.neorg').config,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  ft = 'norg',
}