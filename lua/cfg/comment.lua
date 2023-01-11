local M = {}

function M.config()
  local comment_loaded, comment = pcall(require, 'Comment')
  if not comment_loaded then
    return
  end

  comment.setup()
end

return M
