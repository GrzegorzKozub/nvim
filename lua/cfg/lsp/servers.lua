local M = {}

function M.get()
  local servers = {
    -- 'jsonls',
    'sumneko_lua',
    -- 'vimls',
    -- 'yamlls',
  }
  if vim.fn.has 'win32' == 1 then
    for _, server in ipairs {
      -- 'powershell_es',
    } do
      table.insert(servers, server)
    end
  else
    for _, server in ipairs {
      'bashls',
      -- 'csharp_ls',
      -- 'dockerls',
      -- 'elixirls',
      -- 'eslint',
      -- 'gopls',
      -- 'pyright',
      'tsserver',
    } do
      table.insert(servers, server)
    end
  end
  return servers
end

return M