return {
  'ibhagwan/fzf-lua',
  cmd = { 'FzfLua' },
  config = require('cfg.fzf-lua').config,
  dependencies = { 'echasnovski/mini.icons' },
  keys = {
    '<c-p>',
    '<c-k>',
    '<c-b>',
    '<c-g>',
    '<leader>m',
    '<leader>Q',
    '<leader>L',
    '<leader>gl',
    '<leader>gL',
    '<leader>S',
  },
}
