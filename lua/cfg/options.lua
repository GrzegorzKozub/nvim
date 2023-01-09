local M = {}

function M.config()
  for name, value in pairs {
    backup = true,
    cursorline = true, -- can break per https://github.com/neovim/neovim/issues/9019
    expandtab = true,
    foldenable = false,
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

  for _, sign in ipairs {
    { name = 'DiagnosticSignError', text = '●' },
    { name = 'DiagnosticSignWarn', text = '▲' },
    { name = 'DiagnosticSignHint', text = '◆' },
    { name = 'DiagnosticSignInfo', text = '◆' },
  } do
    vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name, numhl = '' })
  end

  vim.diagnostic.config {
    underline = false,
    virtual_text = {
      spacing = 0,
      prefix = '',
      -- format = function(diagnostic)
      --   return string.format(vim.o.commentstring, diagnostic.message)
      -- end,
    },
    float = { header = '', prefix = '', border = 'rounded' },
    severity_sort = true,
  }

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
end

return M
