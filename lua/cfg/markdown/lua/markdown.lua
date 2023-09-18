local ts = require('nvim-treesitter.ts_utils')

local M = {}

local U = {}

U.find_parent_node = function(node, type)
  if (node == node:root()) then return nil end
  if (node:type() == type) then return node end
  return U.find_parent_node(node:parent(), type)
end

local find_child_node = function(node, type)
  local child = node:child(0)
  while child do
    if (child:type() == type) then return child end
    child = child:next_sibling()
  end
  return nil
end

local set_node_text = function(node, text, bufnr)
  local sr, sc, er, ec = node:range()
  local content = { text }
  if (type(text) == 'table') then content = text end
  vim.api.nvim_buf_set_text(bufnr or 0, sr, sc, er, ec, content)
end

local get_node_text = function(node, bufnr)
  local sr, sc, er, ec = node:range()
  local text = vim.api.nvim_buf_get_text(bufnr or 0, sr, sc, er, ec, {})
  if (#text == 1) then return text[1] end
  return text
end

M.toggle = function()
  local node = ts.get_node_at_cursor(nil, true)
  local item = U.find_parent_node(node, 'list_item')
  if (not item) then
    return
  end

  local unchecked = find_child_node(item, 'task_list_marker_unchecked')
  if unchecked then
    set_node_text(unchecked, '[x]')
    return
  end
  local checked = find_child_node(item, 'task_list_marker_checked')
  local box = checked

  if box then
    set_node_text(box, {})
    local marker = item:child()
    set_node_text(marker, get_node_text(marker):sub(1, 1))
    return
  end

  local content = find_child_node(item, 'paragraph')
  if not content then return end
  local text = get_node_text(content)

  text[1] = '[ ] ' .. text[1]
  set_node_text(content, text)
end

M.setup = function()
  require('cfg.util').nmap('<leader>x', M.toggle)
end

return M