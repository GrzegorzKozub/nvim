local M = {}

local tools = vim.fn.has 'win32' == 0
    and {

      -- servers

      'bash-language-server',
      -- 'csharp-language-server',
      -- 'css-lsp',
      'dockerfile-language-server',
      -- 'elixir-ls',
      'eslint-lsp',
      -- 'gopls',
      -- 'html-lsp',
      'json-lsp',
      'lua-language-server',
      'pyright',
      'taplo',
      'typescript-language-server',
      -- 'vim-language-server',
      'yaml-language-server',

      -- linters

      'hadolint',
      -- 'eslint_d',
      -- 'golangcilint',
      'jsonlint',
      'luacheck',
      -- 'markdownlint',
      'pylint',
      -- 'vint',
      'yamllint',

      -- formatters

      'black',
      'isort',
      'prettier',
      'stylua',
      'taplo',
    }
  or {

    -- servers

    'lua-language-server',
    'pyright',

    -- linters

    -- 'luacheck',
    'pylint',

    -- formatters

    'black',
    'isort',
    'stylua',
  }

function M.config()
  local mason_tool_installer_loaded, mason_tool_installer = pcall(require, 'mason-tool-installer')
  if not mason_tool_installer_loaded then
    return
  end

  mason_tool_installer.setup {
    ensure_installed = tools,
    run_on_start = false,
  }
end

return M