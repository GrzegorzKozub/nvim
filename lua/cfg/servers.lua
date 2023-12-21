local servers = {
  -- 'cssls',
  -- 'html',
  'jsonls',
  'lua_ls',
  'pyright',
  'taplo',
  -- 'vimls',
  'yamlls',
}

if vim.fn.has 'win32' == 0 then
  for _, value in ipairs {
    'bashls',
    -- 'csharp_ls',
    'docker_compose_language_service',
    'dockerls',
    -- 'elixirls',
    'eslint',
    -- 'gopls',
    'tsserver',
  } do
    table.insert(servers, value)
  end
else
  table.insert(servers, 'powershell_es')
end

return servers
