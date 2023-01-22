local M = {}

function M.config()
  local treesitter_loaded, treesitter = pcall(require, 'nvim-treesitter.configs')
  if not treesitter_loaded then
    return
  end

  treesitter.setup {
    auto_install = true,
    ensure_installed = {
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
      'help',
      'html',
      'http',
      'ini',
      'javascript',
      'jq',
      'json',
      'lua',
      'markdown',
      'python',
      'scss',
      'sql',
      'toml',
      'typescript',
      'vim',
      'yaml',
    },
    highlight = { enable = true },
    incremental_selection = { enable = true },
  }

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end

return M