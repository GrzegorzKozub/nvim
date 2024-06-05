local M = {}

function M.config()
  local icons = require('cfg.icons').get()

  for name, value in pairs {
    backup = true,
    cursorline = true, -- can break per https://github.com/neovim/neovim/issues/9019
    expandtab = true,
    fillchars = {
      diff = ' ',
      eob = ' ',
      fold = ' ',
      foldclose = icons.fold.closed,
      foldopen = icons.fold.open,
      vert = ' ',
    },
    foldenable = false,
    foldlevelstart = 99,
    foldmethod = 'syntax',
    ignorecase = true,
    infercase = true,
    listchars = {
      eol = icons.listchars.eol,
      tab = icons.listchars.tab,
      trail = icons.listchars.trail,
    },
    mouse = 'a',
    mousemodel = 'extend',
    number = true,
    pumheight = 16,
    scrolloff = 2,
    shiftwidth = 2,
    showmatch = true,
    showmode = false,
    sidescrolloff = 4,
    smartcase = true,
    smartindent = true,
    softtabstop = 2,
    spelllang = { 'en_gb', 'pl' },
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 2,
    termguicolors = true,
    undofile = true,
    wildmode = { 'longest:full', 'full' },
    wildoptions = 'tagfile',
    wrap = false,
  } do
    vim.opt[name] = value
  end

  -- https://github.com/neovim/neovim/issues/9800
  if vim.opt.diff:get() then
    vim.opt.cursorline = false
  end

  vim.opt.backupdir:remove '.'
  vim.opt.diffopt:append { 'algorithm:histogram', 'indent-heuristic', 'context:3' }
  vim.opt.shortmess:append 'I'
  vim.opt.whichwrap:append '<,>,[,]'

  vim.cmd.language(vim.fn.has 'win32' == 1 and 'English_US' or 'en_US.utf8')

  vim.diagnostic.config {
    float = { header = '', prefix = '', border = 'rounded' },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diag.error,
        [vim.diagnostic.severity.WARN] = icons.diag.warning,
        [vim.diagnostic.severity.INFO] = icons.diag.info,
        [vim.diagnostic.severity.HINT] = icons.diag.hint,
      },
    },
    underline = false,
    virtual_text = {
      spacing = 0,
      prefix = '',
      format = function(diagnostic)
        local sign = diagnostic.severity == vim.diagnostic.severity.ERROR and icons.diag.error
          or diagnostic.severity == vim.diagnostic.severity.WARN and icons.diag.warning
          or icons.diag.info
        return string.format('%s %s', sign, diagnostic.message)
      end,
    },
  }

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0

  vim.g.netrw_banner = 0
  vim.g.netrw_home = vim.fn.stdpath 'data' .. '/state/netrw'
  vim.g.netrw_localcopycmd = 'copy'
end

return M
