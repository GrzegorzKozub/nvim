local M = {}

function M.config()
  local blink_loaded, blink = pcall(require, 'blink.cmp')
  if not blink_loaded then
    return
  end
  blink.setup()
end

return M
