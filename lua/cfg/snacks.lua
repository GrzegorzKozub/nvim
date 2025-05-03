local M = {}

function M.config()
  local snacks_loaded, snacks = pcall(require, 'snacks')
  if not snacks_loaded then
    return
  end

  snacks.setup()
end

return M
