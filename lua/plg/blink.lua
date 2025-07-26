return {
  'saghen/blink.cmp',
  config = require('cfg.blink').config,
  -- event = { 'CmdlineEnter', 'InsertEnter' },
  -- dependencies = { 'rafamadriz/friendly-snippets' },
  event = { 'VeryLazy' }, -- loads 2x faster
  opts_extend = { 'sources.default' },
  version = '1.*',
}
