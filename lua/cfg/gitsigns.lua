local M = {}

function M.config()
  local gitsigns_loaded, gitsigns = pcall(require, 'gitsigns')
  if not gitsigns_loaded then
    return
  end

  local icons = require('cfg.icons').get().gitsigns

  gitsigns.setup {
    signs = {
      add = { text = icons.changed },
      change = { text = icons.changed },
      delete = { text = icons.changed },
      topdelete = { text = icons.changed },
      changedelete = { text = icons.changed },
      untracked = { text = '' },
    },
    signs_staged = {
      add = { text = icons.staged },
      change = { text = icons.staged },
      delete = { text = icons.staged },
      topdelete = { text = icons.staged },
      changedelete = { text = icons.staged },
      untracked = { text = '' },
    },
    current_line_blame_formatter = ' '
      .. icons.git
      .. ' <summary>, <author>, <author_time:%R>, <abbrev_sha>',
    current_line_blame_formatter_nc = ' ' .. icons.git .. ' not committed',
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

      local options = { target = 'all' }

      navigate('[h', function()
        gs.nav_hunk('prev', options)
      end)

      navigate(']h', function()
        gs.nav_hunk('next', options)
      end)

      local nmap = require('cfg.util').nmap

      nmap('<leader>hp', gs.preview_hunk_inline, bufnr)

      nmap('<leader>hs', gs.stage_hunk, bufnr)
      nmap('<leader>hu', gs.undo_stage_hunk, bufnr)
      nmap('<leader>hr', gs.reset_hunk, bufnr)

      nmap('<leader>gr', gs.reset_buffer_index, bufnr)

      nmap('<leader>gb', gs.toggle_current_line_blame, bufnr)
    end,
  }
end

return M
