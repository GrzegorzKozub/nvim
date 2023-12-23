return {
  'hrsh7th/nvim-cmp',
  event = { 'CmdlineEnter', 'InsertEnter' },
  config = require('cfg.cmp').config,
  dependencies = {
    'L3MON4D3/LuaSnip',
    -- 'amarakon/nvim-cmp-fonts',
    'chrisgrieser/cmp-nerdfont',
    'dmitmel/cmp-cmdline-history',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'tamago324/cmp-zsh',
  },
}