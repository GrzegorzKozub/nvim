local M = {}

function M.config()
  local gitsigns_loaded, gitsigns = pcall(require, 'gitsigns')
  if not gitsigns_loaded then
    return
  end

  gitsigns.setup {
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '━' },
      topdelete = { text = '' },
      changedelete = { text = '━' },
      untracked = { text = '┇' },
    },
    attach_to_untracked = false,
    watch_gitdir = { interval = 10000 },
    preview_config = { border = 'rounded', row = -1, col = 2 },
    on_attach = function(bufnr)
      local gitsigns = package.loaded.gitsigns

      local function navigate(keys, action)
        vim.keymap.set('n', keys, function()
          if vim.wo.diff then
            return keys
          end
          vim.schedule(action)
          return '<ignore>'
        end, { buffer = bufnr, expr = true })
      end

      navigate(']h', gitsigns.next_hunk)
      navigate('[h', gitsigns.prev_hunk)

      local nmap = require('cfg.util').nmap

      nmap('<leader>gt', gitsigns.toggle_signs, bufnr)
      nmap('<leader>gh', gitsigns.preview_hunk, bufnr)
      nmap('<leader>gb', function()
        gitsigns.blame_line { full = true }
      end, bufnr)
    end,
  }
end

return M
