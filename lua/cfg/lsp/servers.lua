local M = {}

function M.get()
  local servers = {
    -- 'jsonls',
    -- 'marksman',
    'sumneko_lua',
    -- 'vimls',
    -- 'yamlls',
  }
  if vim.fn.has 'win32' == 1 then
    for _, lsp in ipairs {
      -- 'powershell_es',
    } do
      table.insert(servers, lsp)
    end
  else
    for _, lsp in ipairs {
      'bashls',
      -- 'csharp_ls',
      -- 'dockerls',
      -- 'elixirls',
      -- 'eslint',
      -- 'gopls',
      -- 'pyright',
      -- 'tsserver',
    } do
      table.insert(servers, lsp)
    end
  end
  return servers
end

return M
