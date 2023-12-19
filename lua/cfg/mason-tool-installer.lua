local M = {}

local tools = vim.fn.has 'win32' == 0
    and {

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

  mason_tool_installer.setup { ensure_installed = tools }
end

return M