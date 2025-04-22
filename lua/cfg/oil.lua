local M = {}

function M.config()
  local oil_loaded, oil = pcall(require, 'oil')
  if not oil_loaded then
    return
  end

  oil.setup {
    default_file_explorer = false,
    columns = { 'icon', 'permissions' },
    delete_to_trash = true,
    view_options = { show_hidden = true },
  }
end

return M
