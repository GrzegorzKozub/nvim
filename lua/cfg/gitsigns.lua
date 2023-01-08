local M = {}

local function map(keys, action, bufnr)
  vim.keymap.set('n', keys, action, { noremap = true, silent = true, buffer = bufnr })
end

function M.setup()
  local loaded, plugin = pcall(require, 'gitsigns')
  if not loaded then
    return
  end

  plugin.setup {
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

      map('<leader>gt', gitsigns.toggle_signs, bufnr)
      map('<leader>gh', gitsigns.preview_hunk, bufnr)
      map('<leader>gb', function()
        gitsigns.blame_line { full = true }
      end, bufnr)
    end,
  }
end

return M
