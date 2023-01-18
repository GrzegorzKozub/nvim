local M = {}

function M.config()
  local illuminate_loaded, illuminate = pcall(require, 'illuminate')
  if not illuminate_loaded then
    return
  end

  illuminate.configure {
    delay = 500,
    providers = { 'lsp', 'treesitter' },
  }
end

return M
