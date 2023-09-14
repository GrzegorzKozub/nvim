return {
  'vimwiki/vimwiki',
  config = require('cfg.vimwiki').config,
  event = { 'BufNewFile', 'BufReadPre' },
}