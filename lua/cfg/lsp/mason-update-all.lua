local M = {}

function M.config()
  local mason_update_all_loaded, mason_update_all = pcall(require, 'mason-update-all')
  if not mason_update_all_loaded then
    return
  end

  mason_update_all.setup()
end

return M
