local M = {}

function M.get()
  local servers = {
    'lua_ls',
    'pyright',
  }
  if vim.fn.has 'win32' == 0 then
    for _, server in ipairs {
      'bashls',
      -- 'csharp_ls',
      'dockerls',
      -- 'elixirls',
      'eslint',
      -- 'gopls',
      -- 'html',
      'jsonls',
      'taplo',
      'tsserver',
      -- 'vimls',
      'yamlls',
    } do
      table.insert(servers, server)
    end
  end
  return servers
end

return M