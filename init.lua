require('cfg.options').config()
require('cfg.keys').config()

if not vim.g.vscode then

  require('cfg.autocmds').config()
  require('cfg.markdown').config()
  require('cfg.lazy').config()

end
