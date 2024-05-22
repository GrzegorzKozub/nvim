return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  config = require('cfg.neogit').config,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    -- 'sindrets/diffview.nvim',
  },
}