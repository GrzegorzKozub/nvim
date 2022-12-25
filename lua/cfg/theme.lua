local M = {}

local function normalize_color_scheme(wanted)
  local allowed = { solarized = "solarized8", gruvbox = "gruvbox8_soft" }
  return allowed[wanted] ~= nil and allowed[wanted] or "gruvbox8_soft"
end

local function normalize_background(wanted)
  for _, v in ipairs({ "dark", "light" }) do
    if wanted == v then
      return wanted
    end
  end
  return "dark"
end

local function theme()
  local _, _, color_scheme, background = string.find(vim.env.MY_THEME or "", "([%a%d]+)%-([%a%d]+)")
  return normalize_color_scheme(color_scheme), normalize_background(background)
end

local function hide_tilde_on_empty_lines()
  vim.cmd.highlight({ "EndOfBuffer", "guifg=BG" })
end

local function patch_color_scheme(color_scheme)
  pcall(vim.cmd, "source " .. vim.fn.stdpath("config") .. "/lua/cfg/theme/" .. color_scheme .. ".vim")
end

local function auto_commands(color_scheme)
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      hide_tilde_on_empty_lines()
      patch_color_scheme(color_scheme)
    end,
  })
end

local function options(color_scheme, background)
  vim.opt.background = background
  vim.cmd.colorscheme(color_scheme)

  -- gruvbox
  vim.g.gruvbox_italics = 0
  vim.g.gruvbox_italicize_strings = 0

  -- solarized
  vim.g.solarized_italics = 0
end

function M.init()
  local color_scheme, background = theme()
  auto_commands(color_scheme)
  options(color_scheme, background)
end

return M
