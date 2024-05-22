local M = {}

function M.config()
  local neogit_loaded, neogit = pcall(require, 'neogit')
  if not neogit_loaded then
    return
  end

  neogit.setup {}
end

return M