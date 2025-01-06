local M = {}

function M.config()
  local gitsigns_loaded, gitsigns = pcall(require, 'gitsigns')
  if not gitsigns_loaded then
    return
  end

  local git = '󰊢'
  local sign = '│'
  local sign_staged = '┃'

  gitsigns.setup {
    signs = {
      add = { text = sign },
      change = { text = sign },
      delete = { text = sign },
      topdelete = { text = sign },
      changedelete = { text = sign },
      untracked = { text = '' },
    },
    signs_staged = {
      add = { text = sign_staged },
      change = { text = sign_staged },
      delete = { text = sign_staged },
      topdelete = { text = sign_staged },
      changedelete = { text = sign_staged },
      untracked = { text = '' },
    },
    current_line_blame_formatter = ' '
      .. git
      .. ' <summary>, <author>, <author_time:%R>, <abbrev_sha>',
    current_line_blame_formatter_nc = ' ' .. git .. ' not committed',
    file_blame_opts = {
      auto_sha_colors = false,
      lines = {
        start = '╭',
        continue = '│',
        finish = '╰',
      },
    },
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
      nmap('<leader>hP', gs.preview_hunk, bufnr)

      nmap('<leader>hs', gs.stage_hunk, bufnr)
      nmap('<leader>hu', gs.undo_stage_hunk, bufnr)

      nmap('<leader>hr', gs.reset_hunk, bufnr)
      nmap('<leader>gr', gs.reset_buffer_index, bufnr)

      nmap('<leader>gd', gs.diffthis, bufnr)

      nmap('<leader>gl', gs.toggle_current_line_blame, bufnr)
      nmap('<leader>gb', function()
        gs.blame_line { full = true }
      end, bufnr)
      nmap('<leader>gB', gs.blame, bufnr)
    end,
  }
end

return M
