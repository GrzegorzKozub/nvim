local M = {}

local parsers = {
  'bash',
  'c_sharp',
  'css',
  'csv',
  'dockerfile',
  'editorconfig',
  'elixir',
  'git_config',
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
  'nu',
  'powershell',
  'python',
  'query',
  'rust',
  'scss',
  'sql',
  'ssh_config',
  'tmux',
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