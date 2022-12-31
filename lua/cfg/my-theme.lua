local M = {}

local function map_color_scheme(key)
  local known = {
    gruvbox = { vim = 'gruvbox-material', lualine = 'gruvbox-material' },
  }
  return known[key] ~= nil and known[key] or known.gruvbox
end

local function normalize_background(wanted)
  for _, known in ipairs { 'dark', 'light' } do
    if wanted == known then
      return wanted
    end
  end
  return 'dark'
end

function M.get()
  local _, _, color_scheme, background = string.find(vim.env.MY_THEME or '', '([%a%d]+)%-([%a%d]+)')
  local theme = map_color_scheme(color_scheme)
  theme.background = normalize_background(background)
  return theme
end

return M
