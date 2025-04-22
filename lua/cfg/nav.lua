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

local function tmux_pane_id()
  return tonumber(tmux_pane():sub(2))
end

local function tmux_window_and_pane()
  local layout = tmux_exec "display-message -p '#{window_layout}'"
  local pane_id = tmux_pane_id()
  for pane in layout:gmatch '(%d+x%d+,%d+,%d+,%d+)' do
    if tonumber(pane:match '%d+x%d+,%d+,%d+,(%d+)') == pane_id then
      return {
        width = tonumber(layout:match '^%w+,(%d+)x%d+'),
        height = tonumber(layout:match '^%w+,%d+x(%d+)'),
      }, {
        x = tonumber(pane:match '%d+x%d+,(%d+),%d+,%d+'),
        y = tonumber(pane:match '%d+x%d+,%d+,(%d+),%d+'),
        width = tonumber(pane:match '(%d+)x%d+'),
        height = tonumber(pane:match '%d+x(%d+)'),
      }
    end
  end
end

local function tmux_border(direction)
  local window, pane = tmux_window_and_pane()
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
