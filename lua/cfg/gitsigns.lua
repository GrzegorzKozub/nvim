local M = {}

function M.setup()
  local loaded, plugin = pcall(require, 'gitsigns')
  if not loaded then
    return
  end

  plugin.setup {
    signs = {
      -- alternatives: ┃ ━ ┇
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '─' },
      topdelete = { text = '' },
      changedelete = { text = '─' },
      untracked = { text = '┆' },
    },
    attach_to_untracked = false,
    watch_gitdir = { interval = 10000 },
    on_attach = function(bufnr)
      local gitsigns = package.loaded.gitsigns

      local function navigation(keys, action)
        vim.keymap.set('n', keys, function()
          if vim.wo.diff then
            return keys
          end
          vim.schedule(action)
          return '<Ignore>'
        end, { buffer = bufnr, expr = true })
      end

      navigation(']c', gitsigns.next_hunk)
      navigation('[c', gitsigns.prev_hunk)

      vim.keymap.set('n', '<Leader>g', gitsigns.toggle_signs, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>h', gitsigns.preview_hunk, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>b', function()
        gitsigns.blame_line { full = true }
      end, { buffer = bufnr })
    end,
  }
end

return M
