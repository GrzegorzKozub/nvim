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
  'gosum',
  'html',
  'http',
  'ini',
  'java',
  'javascript',
  'jq',
  'json',
  'kdl',
  'latex',
  'lua',
  'markdown',
  'markdown_inline',
  'nix',
  'nu',
  'po',
  'powershell',
  'python',
  'qmljs',
  'query',
  'rust',
  'scss',
  'sql',
  'ssh_config',
  'terraform',
  'tmux',
  'toml',
  'typescript',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
}

function M.config()
  local treesitter_loaded, treesitter = pcall(require, 'nvim-treesitter')
  if not treesitter_loaded then
    return
  end

  treesitter.install(parsers)

  vim.treesitter.language.register('json', 'jsonc')

  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      if not pcall(vim.treesitter.start, args.buf) or vim.wo[0].diff then
        return
      end
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
    end,
    group = vim.api.nvim_create_augroup('Treesitter', { clear = true }),
  })
end

return M
