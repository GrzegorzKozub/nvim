return {
  'folke/lazydev.nvim',
  cond = function()
    return vim.loop.cwd():match 'nvim'
  end,
  config = require('cfg.lazydev').config,
  ft = 'lua',
}
