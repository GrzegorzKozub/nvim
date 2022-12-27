local M = {}

local function options()
  vim.g.gruvbox_italics = 0
  vim.g.gruvbox_italicize_strings = 0
  vim.g.solarized_italics = 0
end

local function hide_tilde_on_empty_lines()
  vim.cmd.highlight { 'EndOfBuffer', 'guifg=BG' }
end

local function patch_color_scheme(color_scheme)
  pcall(vim.cmd, 'source ' .. vim.fn.stdpath 'config' .. '/lua/cfg/theme/' .. color_scheme .. '.vim')
end

local function refresh_screen()
  vim.cmd.mode()
end

local function auto_fix()
  local group = vim.api.nvim_create_augroup('ThemeAutoFix', { clear = true })
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function(args)
      hide_tilde_on_empty_lines()
      patch_color_scheme(args.match)
      refresh_screen()
    end,
    group = group,
  })
  vim.api.nvim_create_autocmd('OptionSet', {
    pattern = 'background',
    callback = function()
      hide_tilde_on_empty_lines()
      patch_color_scheme(vim.g.colors_name)
      refresh_screen()
    end,
    group = group,
  })
end

local function normalize_color_scheme(wanted)
  local allowed = { solarized = 'solarized8', gruvbox = 'gruvbox8_soft' }
  return allowed[wanted] ~= nil and allowed[wanted] or 'gruvbox8_soft'
end

local function normalize_background(wanted)
  for _, value in ipairs { 'dark', 'light' } do
    if wanted == value then
      return wanted
    end
  end
  return 'dark'
end

local function get_from_env()
  local _, _, color_scheme, background = string.find(vim.env.MY_THEME or '', '([%a%d]+)%-([%a%d]+)')
  return normalize_color_scheme(color_scheme), normalize_background(background)
end

local function apply_current()
  local color_scheme, background = get_from_env()
  vim.opt.background = background
  vim.cmd.colorscheme(color_scheme)
end

function M.setup()
  options()
  auto_fix()
  apply_current()
end

return M
