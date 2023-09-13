return {
  'iamcco/markdown-preview.nvim',
  build = function()
    vim.fn['mkdp#util#install_sync']()
  end,
  config = require('cfg.markdown-preview').config,
  ft = 'markdown',
}