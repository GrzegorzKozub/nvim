require('cfg.lsp.options').config()

require('cfg.lsp.mason').config()
require('cfg.lsp.mason-lspconfig').config()

require('cfg.lsp.neodev').config() -- before nvim-lspconfig
require('cfg.lsp.nvim-lspconfig').config()

require('cfg.lsp.nvim-cmp').config()
