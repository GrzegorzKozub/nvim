local M = {}

function M.config()
  local gitsigns_loaded, gitsigns = pcall(require, 'gitsigns')
  if not gitsigns_loaded then
    return
  end

  local git = '󰊢'
  local sign = '│'

  gitsigns.setup {
    signs = {
      add = { text = sign },
      change = { text = sign },
      delete = { text = sign },
      topdelete = { text = sign },
      changedelete = { text = sign },
      untracked = { text = '' },
    },
    current_line_blame_formatter = ' '
      .. git
      .. ' <summary>, <author>, <author_time:%R>, <abbrev_sha>',
    current_line_blame_formatter_nc = ' ' .. git .. ' not committed',
    watch_gitdir = { interval = 10000 },
    preview_config = { border = 'rounded', row = -1, col = 2 },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function navigate(keys, action)
        vim.keymap.set('n', keys, function()
          if vim.wo.diff then
            return keys
          end
          vim.schedule(action)
          return '<ignore>'
        end, { buffer = bufnr, expr = true })
      end

      local options = { preview = true, target = 'all' }

      navigate('[h', function()
        gs.nav_hunk('prev', options)
      end)

      navigate(']h', function()
        gs.nav_hunk('next', options)
      end)

      local nmap = require('cfg.util').nmap

      nmap('<leader>gh', gs.preview_hunk, bufnr)

      nmap('<leader>gt', gs.toggle_signs, bufnr)
      nmap('<leader>gn', gs.toggle_numhl, bufnr)
      nmap('<leader>gl', gs.toggle_current_line_blame, bufnr)

      nmap('<leader>gb', function()
        gs.blame_line { full = true }
      end, bufnr)
    end,
  }
end

return M