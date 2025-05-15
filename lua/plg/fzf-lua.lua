return {
  'ibhagwan/fzf-lua',
  cmd = { 'FzfLua' },
  config = require('cfg.fzf-lua').config,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    '<c-p>',
    '<c-k>',
    '<c-b>',
    '<c-g>',
    '<c-m>',
    '<leader>Q',
    '<leader>L',
    '<leader>gl',
    '<leader>gL',
    '<leader>S',
  },
}
