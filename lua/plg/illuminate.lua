return {
  'RRethy/vim-illuminate',
  config = require('cfg.illuminate').config,
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  event = { 'BufNewFile', 'BufReadPre' },
}