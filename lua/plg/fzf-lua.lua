return {
  'ibhagwan/fzf-lua',
  cmd = { 'FzfLua' },
  config = require('cfg.fzf-lua').config,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = { '<c-b>', '<c-g>', '<c-k>', '<c-p>', '<c-t>' },
}
