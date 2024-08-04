local deps = {
  'williamboman/mason-lspconfig.nvim',
}

if vim.fn.has 'win32' == 1 then
  table.insert(deps, 'GrzegorzKozub/ahk.nvim')
end

return {
  'neovim/nvim-lspconfig',
  cmd = 'LspInfo',
  cond = not vim.g.vscode,
  config = require('cfg.lspconfig').config,
  dependencies = deps,
  event = { 'BufNewFile', 'BufReadPre' },
}
