local M = {}

local function buffer()
  return vim.fn.bufnr '%'
end

local function encoding_and_fileformat()
  return vim.o.fileencoding .. ' ' .. (vim.o.fileformat == 'unix' and 'lf' or 'crlf')
end

local function progress_and_location()
  return string.format('%.f%s %d %d', 100 * vim.fn.line '.' / vim.fn.line '$', '%%', vim.fn.line '.', vim.fn.col '.')
end

local function contains(table, value)
  for _, v in ipairs(table) do
    if value == v then
      return true
    end
  end
  return false
end

local function buffer_cond()
  return not contains({ 'help', 'netrw', 'packer', 'qf' }, vim.o.filetype)
end

local function filename_cond()
  return not contains({ 'netrw', 'packer', 'qf', 'checkhealth' }, vim.o.filetype)
end

local function encoding_and_fileformat_cond()
  return not contains({ 'help', 'netrw', 'packer', 'qf', 'checkhealth' }, vim.o.filetype)
end

local function mode_fmt(mode)
  return mode:sub(1, 1):lower()
end

function M.config()
  local lualine_loaded, lualine = pcall(require, 'lualine')
  if not lualine_loaded then
    return
  end

  local filename = {
    'filename',
    symbols = { modified = '●', readonly = '■', unnamed = 'untitled' },
    cond = filename_cond,
  }

  lualine.setup {
    options = {
      icons_enabled = false,
      theme = require(require('cfg.my-theme').get().cfg).lualine_theme(),
      section_separators = '',
      component_separators = '',
      refresh = { statusline = 10000 },
    },
    sections = {
      lualine_a = { { 'mode', fmt = mode_fmt } },
      lualine_b = { { buffer, cond = buffer_cond } },
      lualine_c = { filename },
      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_lsp', 'nvim_diagnostic', 'ale' },
          sections = { 'error', 'warn', 'info', 'hint' },
          symbols = { error = '● ', warn = '▲ ', info = '◆ ', hint = '◆ ' },
        },
        { 'diff', symbols = { added = '', modified = '', removed = '' } },
        'filetype',
      },
      lualine_y = {
        { encoding_and_fileformat, cond = encoding_and_fileformat_cond },
      },
      lualine_z = { progress_and_location },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filename },
      lualine_x = { 'filetype' },
      lualine_y = {},
      lualine_z = {},
    },
  }
end

return M
