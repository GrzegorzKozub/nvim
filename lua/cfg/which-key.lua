local M = {}

function M.config()
  local which_key_loaded, which_key = pcall(require, 'which-key')
  if not which_key_loaded then
    return
  end

  which_key.setup { preset = 'helix', notify = false }
end

return M
