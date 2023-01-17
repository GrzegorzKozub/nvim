local M = {}

function M.config()
  local neodev_loaded, neodev = pcall(require, 'neodev')
  if not neodev_loaded then
    return
  end

  neodev.setup()
end

return M
