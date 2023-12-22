local M = {}

function M.nmap(keys, action, buffer)
  local options = { noremap = true, silent = true }
  if buffer ~= nil then
    options.buffer = buffer
  end
  vim.keymap.set('n', keys, action, options)
end

function M.add(target, source)
  for _, value in ipairs(source) do
    table.insert(target, value)
  end
end

return M