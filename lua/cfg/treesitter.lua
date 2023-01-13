local M = {}

function M.config()
  local treesitter_loaded, treesitter = pcall(require, 'nvim-treesitter.configs')
  if not treesitter_loaded then
    return
  end

  treesitter.setup {
    ensure_installed = {
      'bash',
      'c_sharp',
      'dockerfile',
      'elixir',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'go',
      'help',
      'http',
      'javascript',
      'jq',
      'json',
      'lua',
      'markdown',
      'python',
      'sql',
      'toml',
      'typescript',
      'vim',
      'yaml',
    },
    auto_install = true,
    highlight = { enable = true },
    incremental_selection = { enable = true },
  }

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end

return M
