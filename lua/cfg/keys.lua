local M = {}

local options = { noremap = true, silent = true }

local function neovim()
  -- delete with backspace in visual mode
  vim.keymap.set("v", "<BS>", "d", options)

  -- visual block (not needed on linux)
  -- vim.keymap.set("", "<C-Q>", "<C-V>", options)

  -- select all
  vim.keymap.set("n", "<C-A>", "ggVG", options)

  -- clipboard
  vim.keymap.set("v", "<C-C>", '"+y', options)
  vim.keymap.set("v", "<C-X>", '"+x', options) -- conflicts with tmux
  vim.keymap.set({ "n", "v", "x" }, "<C-V>", '"+gP', options)
  vim.keymap.set({ "c", "i" }, "<C-V>", "<C-R>+", { noremap = true })
end

local function plugins()
  -- netrw
  vim.keymap.set("n", "<Leader>e", ":Explore<CR>", options)

  -- neoformat
  vim.keymap.set("n", "<Leader>f", ":Neoformat<CR>", options)

  -- markdown-preview.nvim
  vim.keymap.set("n", "<Leader>mp", ":MarkdownPreviewToggle<CR>", options)
end

function M.init()
  neovim()
  plugins()
end

return M
