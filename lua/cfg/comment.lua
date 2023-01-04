local M = {}

function M.setup()
  local loaded, plugin = pcall(require, 'Comment')
  if not loaded then
    return
  end

  plugin.setup()
end

return M
