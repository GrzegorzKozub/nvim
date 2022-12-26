local M = {}

function M.setup()
  for name, value in pairs {
    backup = true,
    cursorline = true, -- can break per https://github.com/neovim/neovim/issues/9019
    expandtab = true,
    foldlevelstart = 99,
    foldmethod = 'syntax',
    ignorecase = true,
    infercase = true,
    lazyredraw = true,
    listchars = { tab = '→ ', eol = '¬', trail = '·' },
    mouse = 'a',
    mousemodel = 'extend',
    number = true,
    scrolloff = 3,
    shiftwidth = 2,
    showmatch = true,
    showmode = false,
    sidescrolloff = 15,
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

  vim.opt.backupdir:remove '.'
  vim.opt.diffopt:append { 'algorithm:histogram', 'indent-heuristic', 'context:3' }
  vim.opt.fillchars:append { vert = ' ' }
  vim.opt.shortmess:append 'I'
  vim.opt.whichwrap:append '<,>,[,]'

  vim.cmd.language(vim.fn.has 'win32' == 1 and 'English_US' or 'en_US.utf8')

  vim.g.netrw_banner = 0
  vim.g.netrw_home = vim.fn.stdpath 'data' .. '/state/netrw'
  vim.g.netrw_localcopycmd = 'copy'
end

return M
