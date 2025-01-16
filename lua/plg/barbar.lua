return {
  'romgrk/barbar.nvim',
  config = require('cfg.barbar').config,
  init = function()
    vim.g.barbar_auto_setup = false
  end,
}
