local M = {}

function M.config()
  local lazydev_loaded, lazydev = pcall(require, 'lazydev')
  if not lazydev_loaded then
    return
  end

  lazydev.setup()
end

return M
