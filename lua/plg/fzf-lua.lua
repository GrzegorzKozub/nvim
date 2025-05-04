return {
  'ibhagwan/fzf-lua',
  cmd = { 'FzfLua' },
  config = require('cfg.fzf-lua').config,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = { '<c-b>', '<c-p>', '<c-k>', '<c-g>' },
}
