require('cfg.options').config()
require('cfg.autocmds').config()
require('cfg.keys').config()
require('cfg.gui').config()

require('cfg.plugins').config()

require('cfg.gruvbox-material').config()

require('cfg.lualine').config()
require('cfg.gitsigns').config()
require('cfg.hexokinase').config()

require('cfg.telescope').config()

require('cfg.mason').config()
require('cfg.mason-lspconfig').config()
require('cfg.mason-update-all').config()

require('cfg.neodev').config() -- before nvim-lspconfig
require('cfg.nvim-lspconfig').config()

require('cfg.nvim-cmp').config()

require('cfg.null-ls').config()
require('cfg.mason-null-ls').config() -- after mason and null-ls

require('cfg.treesitter').config()

require('cfg.illuminate').config()

require('cfg.trouble').config()

require('cfg.comment').config()

require('cfg.vimwiki').config()

require('cfg.markdown-preview').config()