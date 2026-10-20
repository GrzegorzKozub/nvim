local M = {}

function M.add(target, source)
  for _, value in ipairs(source) do
    table.insert(target, value)
  end
end

local function map(mode, keys, action, buffer)
  local options = { noremap = true, silent = true }
  if buffer ~= nil then
    options.buffer = buffer
  end
  vim.keymap.set(mode, keys, action, options)
end

function M.nmap(keys, action, buffer)
  map('n', keys, action, buffer)
end

function M.tmap(keys, action, buffer)
  map('t', keys, action, buffer)
end

return M
