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

local function options(color_scheme, background)
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      -- hide tilde on empty lines
      vim.cmd([[ highlight EndOfBuffer guifg=BG ]])
      -- apply color scheme patch
      pcall(vim.cmd, "source " .. vim.fn.stdpath("config") .. "/theme/" .. color_scheme .. ".vim")
    end,
  })
  vim.opt.background = background
  vim.cmd.colorscheme(color_scheme)
  -- vim-gruvbox8
  vim.g.gruvbox_italics = 0
  vim.g.gruvbox_italicize_strings = 0
  -- vim-solarized8
  vim.g.solarized_italics = 0
end

local function lightline(color_scheme)
  -- lightline.vim
  vim.g.lightline = { colorscheme = color_scheme }
end

function M.init()
  local color_scheme, background = theme()
  options(color_scheme, background)
  lightline(color_scheme)
end

return M
