return {
  'RRethy/vim-illuminate',
  cond = not vim.g.vscode,
  config = require('cfg.illuminate').config,
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  event = { 'BufNewFile', 'BufReadPre' },
}