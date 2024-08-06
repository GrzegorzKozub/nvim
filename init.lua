require('cfg.options').config()
require('cfg.keys').config()
require('cfg.yank-highlight').config()

if not vim.g.vscode then
  require('cfg.file-types').config()
  require('cfg.markdown').config()
  require('cfg.resume').config()
  require('cfg.wt').config()
  require('cfg.lazy').config()
end
