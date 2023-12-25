return {
  'folke/noice.nvim',
  config = require('cfg.noice').config,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  event = 'VeryLazy',
}