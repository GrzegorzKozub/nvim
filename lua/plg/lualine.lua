return {
  'nvim-lualine/lualine.nvim',
  cond = not vim.g.vscode,
  config = require('cfg.lualine').config,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'sainnhe/gruvbox-material',
  },
}