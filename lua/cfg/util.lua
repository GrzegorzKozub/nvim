local M = {}

function M.nmap(keys, action, buffer)
  local options = { noremap = true, silent = true }
  if buffer ~= nil then
    options.buffer = buffer
  end
  vim.keymap.set('n', keys, action, options)
end

return M
