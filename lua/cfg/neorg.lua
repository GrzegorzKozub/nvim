local M = {}

function M.config()
  local neorg_loaded, neorg = pcall(require, 'neorg')
  if not neorg_loaded then
    return
  end

  neorg.setup {
    load = {
      ['core.defaults'] = {},
      ['core.concealer'] = { config = { icons = { todo = { uncertain = { icon = '' } } } } },
      ['core.dirman'] = { config = { workspaces = { work = '~/code/apsis' }, default_workspace = 'work' } },
    },
  }
end

return M