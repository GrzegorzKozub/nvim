local M = {}

local options = { noremap = true, silent = true }

local function neovim()
end

local function plugins()
  -- netrw
  vim.api.nvim_set_keymap("n", "<Leader>e", ":Explore<CR>", options)

  -- neoformat
  vim.api.nvim_set_keymap("n", "<Leader>f", ":Neoformat<CR>", options)

  -- markdown-preview.nvim
  vim.api.nvim_set_keymap("n", "<Leader>mp", ":MarkdownPreviewToggle<CR>", options)
end

function M.init()
  neovim()
  plugins()
end

return M
