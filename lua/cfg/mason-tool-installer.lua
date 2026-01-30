local M = {}

local add = require('cfg.util').add

local servers = {
  'basedpyright',
  'eslint-lsp',
  'gopls',
  'harper-ls',
  'json-lsp',
  'lua-language-server',
  'rust-analyzer',
  'taplo',
  'typescript-language-server',
  'yaml-language-server',
} -- csharp-language-server elixir-ls jdtls

if vim.fn.has 'win32' == 0 then
  add(servers, {
    'ansible-language-server',
    'bash-language-server',
    'docker-compose-language-service',
    'dockerfile-language-server',
    'qmlls',
    'terraform-ls',
    'texlab',
  })
else
  add(servers, { 'powershell-editor-services' })
end

local linters = {
  'eslint_d',
  'golangci-lint',
  'jsonlint',
  'ruff',
  'yamllint',
}

if vim.fn.has 'win32' == 0 then
  add(linters, {
    'ansible-lint',
    'hadolint',
    'luacheck', -- installed manually on windows
    'tflint',
  })
end

local formatters = {
  'goimports',
  'prettier',
  -- 'ruff', -- ensure_installed must be unique or MasonToolsUpdateCompleted doesn't fire
  'stylua',
  'xmlformatter',
}

if vim.fn.has 'win32' == 0 then
  add(formatters, { 'shfmt' })
end

local tools = {}
add(tools, servers)
add(tools, linters)
add(tools, formatters)

function M.config()
  local mason_tool_installer_loaded, mason_tool_installer =
    pcall(require, 'mason-tool-installer')
  if not mason_tool_installer_loaded then
    return
  end

  mason_tool_installer.setup {
    ensure_installed = tools,
    run_on_start = false,
  }
end

return M
