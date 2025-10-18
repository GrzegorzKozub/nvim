local add = require('cfg.util').add

local servers = {
  'ansiblels',
  -- 'csharp_ls',
  'docker_compose_language_service',
  'dockerls',
  -- 'elixirls',
  'eslint',
  'gopls',
  'harper_ls',
  'jsonls',
  'lua_ls',
  'nushell',
  'pyright',
  'rust_analyzer',
  'taplo',
  'texlab',
  'ts_ls',
  'yamlls',
}

if vim.fn.has 'win32' == 0 then
  add(servers, { 'bashls' })
else
  add(servers, { 'powershell_es' })
end

return servers
