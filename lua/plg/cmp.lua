local deps = {
  'L3MON4D3/LuaSnip',
  'dmitmel/cmp-cmdline-history',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
}

if vim.fn.has 'win32' == 0 then
  table.insert(deps, 'tamago324/cmp-zsh')
end

return {
  'hrsh7th/nvim-cmp',
  event = { 'CmdlineEnter', 'InsertEnter' },
  cond = not vim.g.vscode,
  config = require('cfg.cmp').config,
  dependencies = deps,
}