local M = {}

local options = { noremap = true, silent = true }

function M.setup()
  local loaded, plugin = pcall(require, 'nvim-tree')
  if not loaded then
    return
  end

  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  plugin.setup {
    hijack_cursor = true,
    sync_root_with_cwd = true,
    git = { show_on_dirs = false },
    modified = { enable = true, show_on_dirs = false },
    on_attach = function()
      vim.cmd [[
        hi! link NvimTreeNormal Normal
        hi! link NvimTreeEndOfBuffer EndOfBuffer
        hi! link NvimTreeRootFolder Aqua
        hi! link NvimTreeFolderName Blue
        hi! link NvimTreeOpenedFolderName Blue
        hi! link NvimTreeEmptyFolderName Blue
        hi! link NvimTreeLiveFilterPrefix Orange
      ]]
    end,
    view = { adaptive_size = true, signcolumn = 'auto' },
    renderer = {
      group_empty = true,
      root_folder_label = function(cwd)
        return vim.fn.fnamemodify(cwd, ':t')
      end,
      icons = {
        show = { file = false, folder = false, folder_arrow = false, git = false, modified = false },
        glyphs = { symlink = '' },
      },
      special_files = {},
      symlink_destination = false,
    },
    actions = {
      expand_all = { exclude = { '.git', 'dist', 'node_modules' } },
      file_popup = { open_win_config = { border = 'rounded', row = -1, col = 2 } },
    },
    live_filter = { prefix = 'filter: ' },
  }

  vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>', options)
end

return M
