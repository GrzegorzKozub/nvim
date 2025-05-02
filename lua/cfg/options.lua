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
    scrolloff = 4,
    shiftwidth = 2,
    showmatch = true,
    showmode = false,
    sidescrolloff = 8,
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
    -- updatetime = 3000, -- speed up CursorHold
    wildmode = { 'longest:full', 'full' },
    wildoptions = 'tagfile',
    -- winborder = 'rounded', -- https://github.com/neovim/neovim/pull/31074
    wrap = false,
  } do
    vim.opt[name] = value
  end

  -- https://github.com/neovim/neovim/issues/9800
  if vim.opt.diff:get() then
    vim.opt.cursorlineopt = 'number'
  end

  vim.opt.backupdir:remove '.'
  vim.opt.completeopt:append 'fuzzy'
  vim.opt.diffopt:append { 'algorithm:histogram', 'indent-heuristic', 'context:3' }
  vim.opt.shortmess:append 'I'
  vim.opt.whichwrap:append '<,>,[,]'

  vim.cmd.language(vim.fn.has 'win32' == 1 and 'English_US' or 'en_US.utf8')

  local function format(diag)
    local sign = diag.severity == vim.diagnostic.severity.ERROR and icons.diag.error
      or diag.severity == vim.diagnostic.severity.WARN and icons.diag.warning
      or icons.diag.info
    return string.format('%s %s', sign, diag.message)
  end

  vim.diagnostic.config {
    float = { border = 'rounded', format = format, header = '', prefix = '', suffix = '' },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diag.error,
        [vim.diagnostic.severity.WARN] = icons.diag.warning,
        [vim.diagnostic.severity.INFO] = icons.diag.info,
        [vim.diagnostic.severity.HINT] = icons.diag.hint,
      },
    },
    underline = true,
    virtual_lines = { current_line = true, format = format },
    virtual_text = { format = format, prefix = '', spacing = 0 },
  }

  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0

  vim.g.netrw_banner = 0
  vim.g.netrw_home = vim.fn.stdpath 'data' .. '/state/netrw'
  vim.g.netrw_localcopycmd = 'copy'
end

return M
