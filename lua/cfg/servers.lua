local M = {}

function M.get()
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
    for _, server in ipairs {
      'bashls',
      -- 'csharp_ls',
      'docker_compose_language_service',
      'dockerls',
      -- 'elixirls',
      'eslint',
      -- 'gopls',
      'tsserver',
    } do
      table.insert(servers, server)
    end
  end
  if vim.fn.has 'win32' == 1 then
    for _, server in ipairs {
      'powershell_es',
    } do
      table.insert(servers, server)
    end
  end
  return servers
end

return M