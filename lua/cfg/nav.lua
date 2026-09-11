local M = {}

local function nvim_window(direction)
  return vim.api.nvim_call_function('winnr', { direction })
end

local function nvim_border(direction)
  return nvim_window() == nvim_window('1' .. direction)
end

local function nvim_float()
  return vim.api.nvim_win_get_config(0).relative ~= ''
end

local function nvim_cmd_mode()
  return vim.fn.getcmdwintype() ~= ''
end

local function nvim_change_window(direction)
  return vim.api.nvim_command((vim.v.count or 1) .. 'wincmd ' .. direction)
end

local function tmux()
  return os.getenv 'TMUX'
end

local function tmux_socket()
  return vim.split(tmux(), ',')[1]
end

local function tmux_exec(args)
  local cmd = string.format('tmux -S %s %s', tmux_socket(), args)
  local handle = assert(io.popen(cmd))
  local result = handle:read '*a'
  handle:close()
  return result
end

local function tmux_zoom()
  return tmux_exec("display-message -p '#{window_zoomed_flag}'"):find '1'
end

local function tmux_pane()
  return os.getenv 'TMUX_PANE'
end

local function tmux_find_pane(L, pane_id)
  if L.t == 'p' then
    if L.I == pane_id then
      return L
    end
    return nil
  end
  for _, child in ipairs(L.c or {}) do
    local pane = tmux_find_pane(child, pane_id)
    if pane then
      return pane
    end
  end
end

local function tmux_window_and_pane()
  local ok, layout = pcall(vim.json.decode, tmux_exec "display-message -p '#{window_layout}'")
  if not ok or not layout.L then
    return
  end
  local pane = tmux_find_pane(layout.L, tmux_pane())
  if not pane then
    return
  end
  return { width = layout.L.w, height = layout.L.h }, {
    x = pane.x,
    y = pane.y,
    width = pane.w,
    height = pane.h,
  }
end

local function tmux_border(direction)
  local window, pane = tmux_window_and_pane()
  if not window or not pane then
    return true
  end
  if direction == 'h' then
    return pane.x == 0
  elseif direction == 'j' then
    return pane.y + pane.height == window.height
  elseif direction == 'k' then
    return pane.y == 0
  elseif direction == 'l' then
    return pane.x + pane.width == window.width
  end
end

local function tmux_can_change_pane(direction)
  if tmux() == nil or tmux_zoom() then
    return false
  end
  if not tmux_border(direction) then
    return true
  end
  return false
end

local function tmux_change_pane(direction)
  local directions = { h = 'L', j = 'D', k = 'U', l = 'R' }
  tmux_exec(string.format('select-pane -t %s -%s', tmux_pane(), directions[direction]))
end

local function nav(direction)
  if (nvim_border(direction) or nvim_float()) and tmux_can_change_pane(direction) then
    tmux_change_pane(direction)
  elseif not nvim_cmd_mode() then
    nvim_change_window(direction)
  end
end

function M.config()
  if vim.fn.has 'win32' == 1 then
    return
  end
  local nmap = require('cfg.util').nmap
  nmap('<a-left>', function()
    nav 'h'
  end)
  nmap('<a-down>', function()
    nav 'j'
  end)
  nmap('<a-up>', function()
    nav 'k'
  end)
  nmap('<a-right>', function()
    nav 'l'
  end)
end

return M
