local add = require('cfg.util').add

local servers = {
  'jsonls',
  'lua_ls',
  'pyright',
  'rust_analyzer',
  'taplo',
  'yamlls',
}

if vim.fn.has 'win32' == 0 then
  add(servers, {
    'bashls',
    -- 'csharp_ls',
    'docker_compose_language_service',
    'dockerls',
    -- 'elixirls',
    'eslint',
    'gopls',
    'tsserver',
  })
else
  add(servers, {
    'ahk',
    'powershell_es',
  })
end

return servers