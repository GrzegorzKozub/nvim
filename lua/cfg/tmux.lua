local M = {}

function M.config()
  local tmux_loaded, tmux = pcall(require, 'tmux')
  if not tmux_loaded then
    return
  end

  tmux.setup {
    copy_sync = { enable = false },
    navigation = {
      cycle_navigation = false,
      enable_default_keybindings = false,
      persist_zoom = true,
    },
    resize = { enable_default_keybindings = false },
    swap = { enable_default_keybindings = false },
  }

  local nmap = require('cfg.util').nmap

  nmap('<a-left>', tmux.move_left)
  nmap('<a-down>', tmux.move_bottom)
  nmap('<a-up>', tmux.move_top)
  nmap('<a-right>', tmux.move_right)
end

return M
