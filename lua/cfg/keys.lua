local M = {}

local options = { noremap = true, silent = true }

local function markdown()
  vim.api.nvim_set_keymap("n", "<Leader>mp", ":MarkdownPreviewToggle<CR>", options)
end

local function neoformat()
  vim.api.nvim_set_keymap("n", "<Leader>f", ":Neoformat<CR>", options)
end

local function netrw()
  vim.api.nvim_set_keymap("n", "<Leader>e", ":Explore<CR>", options)
end

function M.init()
  markdown()
  neoformat()
  netrw()
end

return M
