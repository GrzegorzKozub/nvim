local M = {}

local function options()
  vim.g.gruvbox_material_background = 'soft'
  vim.g.gruvbox_material_better_performance = 1
  vim.g.gruvbox_material_disable_italic_comment = 1
  vim.g.gruvbox_material_foreground = 'original' -- switch to material soon
  vim.g.gruvbox_material_lightline_disable_bold = 1
  vim.g.gruvbox_material_show_eob = 0
  vim.g.gruvbox_material_statusline_style = 'original' -- switch to default soon
  vim.g.gruvbox_material_transparent_background = 2
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
      patch_color_scheme(args.match)
      refresh_screen()
    end,
    group = group,
  })
end

local function normalize_color_scheme(wanted)
  local allowed = { gruvbox = 'gruvbox-material' }
  return allowed[wanted] ~= nil and allowed[wanted] or 'gruvbox-material'
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
