local M = {}

function M.setup()
  local loaded, comment = pcall(require, 'Comment')
  if not loaded then
    return
  end

  comment.setup()
end

return M
