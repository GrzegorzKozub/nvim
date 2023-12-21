local M = {}

local parsers = {
  'bash',
  'c_sharp',
  'css',
  'dockerfile',
  'elixir',
  'gitattributes',
  'gitcommit',
  'gitignore',
  'go',
  'gomod',
  'html',
  'http',
  'ini',
  'javascript',
  'jq',
  'json',
  'jsonc',
  'lua',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'scss',
  'sql',
  'toml',
  'typescript',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
}

function M.config()
  local treesitter_loaded, treesitter = pcall(require, 'nvim-treesitter.configs')
  if not treesitter_loaded then
    return
  end

  treesitter.setup {
    auto_install = true,
    ensure_installed = parsers,
    highlight = { enable = true },
    incremental_selection = { enable = true },
    sync_install = #vim.api.nvim_list_uis() == 0, -- headless
  }

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end

return M
