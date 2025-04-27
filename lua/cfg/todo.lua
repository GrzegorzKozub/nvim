local M = {}

local function find_parent_node(node, type)
  if node == node:root() then
    return nil
  end
  if node:type() == type then
    return node
  end
  return find_parent_node(node:parent(), type)
end

local function find_child_node(node, type)
  local child = node:child(0)
  while child do
    if child:type() == type then
      return child
    end
    child = child:next_sibling()
  end
  return nil
end

local function set_node_text(node, text)
  local sr, sc, er, ec = node:range()
  vim.api.nvim_buf_set_text(0, sr, sc, er, ec, (type(text) == 'table' and text or { text }))
end

local function get_node_text(node)
  local sr, sc, er, ec = node:range()
  local text = vim.api.nvim_buf_get_text(0, sr, sc, er, ec, {})
  return (#text == 1 and text[1] or text)
end

local function toggle()
  local node = require('vim.treesitter').get_node()
  local item = find_parent_node(node, 'list_item')
  if not item then
    return
  end
  local unchecked = find_child_node(item, 'task_list_marker_unchecked')
  if unchecked then
    set_node_text(unchecked, '[x]')
    return
  end
  local checked = find_child_node(item, 'task_list_marker_checked')
  if checked then
    set_node_text(checked, nil)
    local marker = item:child()
    set_node_text(marker, get_node_text(marker):sub(1, 1))
    return
  end
  local content = find_child_node(item, 'paragraph')
  if not content then
    return
  end
  local text = get_node_text(content)
  text[1] = '[ ] ' .. text[1]
  set_node_text(content, text)
end

function M.config()
  require('cfg.util').nmap('<leader>x', toggle)
end

return M
