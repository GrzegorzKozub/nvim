local M = {}

function M.setup()
  local loaded, gitsigns = pcall(require, 'gitsigns')
  if not loaded then
    return
  end

  gitsigns.setup {
    signs = {
      -- alternatives: ┃ ━ ┇
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '─' },
      topdelete = { text = '' },
      changedelete = { text = '─' },
      untracked = { text = '┆' },
    },
    watch_gitdir = { interval = 10000 },
    attach_to_untracked = false,
  }
end

return M
