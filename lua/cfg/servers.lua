local add = require('cfg.util').add

local servers = {
  -- 'csharp_ls',
  'docker_compose_language_service',
  'dockerls',
  -- 'elixirls',
  'eslint',
  'gopls',
  'jsonls',
  'lua_ls',
  'pyright',
  'rust_analyzer',
  'taplo',
  'tsserver',
  'yamlls',
}

if vim.fn.has 'win32' == 0 then
  add(servers, {
    'bashls',
  })
else
  add(servers, {
    'ahk',
    'powershell_es',
  })
end

return servers