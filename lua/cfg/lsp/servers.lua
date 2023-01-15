local M = {}

function M.get()
  local servers = {
    'sumneko_lua',
  }
  if vim.fn.has 'win32' == 0 then
    for _, server in ipairs {
      'bashls',
      'csharp_ls',
      'dockerls',
      'elixirls',
      'eslint',
      'gopls',
      'html',
      'jsonls',
      'pyright',
      'tsserver',
      'vimls',
      'yamlls',
    } do
      table.insert(servers, server)
    end
  else
    for _, server in ipairs {
      -- 'powershell_es',
    } do
      table.insert(servers, server)
    end
  end
  return servers
end

return M
