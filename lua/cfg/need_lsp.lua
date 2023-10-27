local M = {}

function M.events()
  return { 'BufNewFile', 'BufReadPre' }
end

function M.file_types()
  return { 'json' }
end

return M