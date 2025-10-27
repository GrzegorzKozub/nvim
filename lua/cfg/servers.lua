local add = require('cfg.util').add

local servers = {
  'eslint',
  'gopls',
  'harper_ls',
  'jsonls',
  'lua_ls',
  'nushell',
  'pyright',
  'rust_analyzer',
  'taplo',
  'ts_ls',
  'yamlls',
} -- csharp_ls elixirls jdtls

if vim.fn.has 'win32' == 0 then
  add(servers, {
    'ansiblels',
    'bashls',
    'docker_compose_language_service',
    'dockerls',
    'qmlls',
    'texlab',
  })
else
  add(servers, { 'powershell_es' })
end

return servers
