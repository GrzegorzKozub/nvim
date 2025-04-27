local M = {}

local devicons = require 'cfg.web-devicons'
local icons = require('cfg.icons').get()

local function buffer()
  return vim.fn.bufnr '%'
end

local function encoding_and_fileformat()
  return (vim.o.fileencoding == '' and '' or vim.o.fileencoding .. ' ')
    .. (vim.o.fileformat == 'unix' and 'lf' or 'crlf')
end

local function progress_and_location()
  return string.format(
    '%.f%s %d %d',
    100 * vim.fn.line '.' / vim.fn.line '$',
    '%%',
    vim.fn.line '.',
    vim.fn.col '.'
  )
end

local function contains(table, item)
  for _, value in ipairs(table) do
    if item == value then
      return true
    end
  end
  return false
end

local function buffer_cond()
  return not contains({ 'help', 'netrw', 'qf' }, vim.o.filetype) -- trouble
end

local function filename_cond()
  return not contains({ 'netrw', 'qf', 'checkhealth' }, vim.o.filetype) -- trouble
end

local function encoding_and_fileformat_cond()
  return not contains({ 'checkhealth', 'help', 'netrw', 'qf' }, vim.o.filetype) -- trouble
    and not (vim.o.buftype ~= '' and vim.o.buftype == 'terminal')
end

local function mode_fmt(mode)
  return mode:sub(1, 1):lower()
end

local function filetype_fmt(filetype)
  if filetype == '' and vim.o.buftype ~= 'terminal' then
    return ''
  end
  local icon = devicons.icon(0, filetype)
  local name = vim.o.buftype == 'terminal' and 'term' or filetype:lower()
  if filetype == 'qf' then
    icon = icons.qf.list
    -- elseif filetype == 'trouble' then
    --   icon = icons.trouble.list
  end
  return (icon == nil and '' or icon .. ' ') .. name
end

local function tabs_fmt(name, context)
  local bufnr = vim.fn.tabpagebuflist(context.tabnr)[vim.fn.tabpagewinnr(context.tabnr)]
  local buftype = vim.fn.getbufvar(bufnr, '&buftype')
  local filetype = vim.fn.getbufvar(bufnr, '&filetype')
  local icon = devicons.icon(bufnr, filetype)
  local mod = vim.fn.getbufvar(bufnr, '&mod')
  if buftype == 'terminal' then
    name = 'term'
  elseif filetype == 'TelescopePrompt' then
    icon = icons.telescope.search
    name = 'search'
    mod = 0
  elseif filetype == 'checkhealth' then
    name = 'checkhealth'
  elseif filetype == 'qf' then
    icon = icons.qf.list
    name = 'qf'
    -- elseif filetype == 'trouble' then
    --   icon = icons.trouble.list
    --   name = 'trouble'
  elseif name == '[No Name]' then
    name = 'untitled'
  end
  return (icon == nil and '' or icon .. ' ')
    .. name
    .. (mod == 1 and ' ' .. icons.file.modified or '')
end

function M.config()
  local lualine_loaded, lualine = pcall(require, 'lualine')
  if not lualine_loaded then
    return
  end

  local filename = {
    'filename',
    symbols = {
      modified = icons.file.modified,
      readonly = icons.file.readonly,
      unnamed = 'untitled',
    },
    cond = filename_cond,
  }

  local filetype = { 'filetype', fmt = filetype_fmt }

  lualine.setup {
    options = {
      icons_enabled = false,
      theme = require('cfg.' .. require('cfg.theme').get().vim).lualine_theme(),
      component_separators = '',
      section_separators = '',
      always_show_tabline = false,
    },
    sections = {
      lualine_a = { { 'mode', fmt = mode_fmt } },
      lualine_b = { { buffer, cond = buffer_cond } },
      lualine_c = { filename },
      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'error', 'warn', 'info', 'hint' },
          symbols = {
            error = icons.diag.error .. ' ',
            warn = icons.diag.warning .. ' ',
            info = icons.diag.info .. ' ',
            hint = icons.diag.hint .. ' ',
          },
        },
        {
          'diff',
          symbols = {
            added = icons.diff.added,
            modified = icons.diff.modified,
            removed = icons.diff.removed,
          },
        },
        filetype,
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
      lualine_x = { filetype },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {
      lualine_a = {
        {
          'tabs',
          tab_max_length = 32,
          max_length = vim.o.columns,
          mode = 1,
          show_modified_status = false,
          tabs_color = { active = 'lualine_c_normal', inactive = 'lualine_c_inactive' },
          fmt = tabs_fmt,
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  }
end

return M
