local add = require('cfg.util').add

local servers = {
  'ahk',
  'jsonls',
  'lua_ls',
  'pyright',
  'taplo',
  'yamlls',
}

if vim.fn.has 'win32' == 0 then
  add(servers, {
    'bashls',
    -- 'cssls',
    -- 'csharp_ls',
    'docker_compose_language_service',
    'dockerls',
    -- 'elixirls',
    'eslint',
    -- 'gopls',
    -- 'html',
    'tsserver',
    -- 'vimls',
  })
else
  add(servers, { 'powershell_es' })
end

return servers