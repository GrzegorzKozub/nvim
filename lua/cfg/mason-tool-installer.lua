local M = {}

local add = require('cfg.util').add

local servers = {
  'json-lsp',
  'lua-language-server',
  'pyright',
  'rust-analyzer',
  'taplo', -- also a formatter
  'yaml-language-server',
}

if vim.fn.has 'win32' == 0 then
  add(servers, {
    'bash-language-server',
    -- 'csharp-language-server',
    'docker-compose-language-service',
    'dockerfile-language-server',
    -- 'elixir-ls',
    'eslint-lsp',
    'gopls',
    'typescript-language-server',
  })
else
  add(servers, { 'powershell-editor-services' })
end

local linters = {
  'jsonlint',
  'pylint',
  'yamllint',
}

if vim.fn.has 'win32' == 0 then
  add(linters, {
    'eslint_d',
    'golangci-lint',
    'hadolint',
    'luacheck', -- installed manually on Windows
  })
end

local formatters = {
  'black',
  'isort',
  'prettier',
  'stylua',
  'xmlformatter',
}

local tools = {}
add(tools, servers)
add(tools, linters)
add(tools, formatters)

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