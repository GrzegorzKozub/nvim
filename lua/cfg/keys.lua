local M = {}

local options = { noremap = true, silent = true }

local function toggle_quick_fix()
  local open = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      open = true
    end
  end
  vim.cmd(open and "cclose" or "copen")
end

local function neovim()
  vim.keymap.set("v", "<BS>", "d", options)

  vim.keymap.set("n", "<C-A>", "ggVG", options)

  vim.keymap.set("v", "<C-C>", '"+y', options)
  vim.keymap.set("v", "<C-X>", '"+x', options) -- conflicts with tmux
  vim.keymap.set({ "n", "v", "x" }, "<C-V>", '"+gP', options)
  vim.keymap.set({ "c", "i" }, "<C-V>", "<C-R>+", { noremap = true })

  vim.api.nvim_create_user_command("W", "w", {})
  vim.api.nvim_create_user_command("Q", "q", {})

  vim.api.nvim_create_user_command("HlsearchOff", "nohlsearch", {})
  vim.keymap.set("n", "<Leader>h", ":HlsearchOff<CR>", options)

  vim.api.nvim_create_user_command("WrapToggle ", "set wrap! linebreak! nolist", {})
  vim.keymap.set("n", "<Leader>w", ":WrapToggle<CR>", options)

  vim.api.nvim_create_user_command("ListToggle", "set list!", {})
  vim.keymap.set("n", "<Leader>i", ":ListToggle<CR>", options)

  vim.api.nvim_create_user_command("RelativeNumberToggle", "set relativenumber!", {})
  vim.keymap.set("n", "<Leader>r", ":RelativeNumberToggle<CR>", options)

  vim.api.nvim_create_user_command("SpellToggle", "set spell!", {})
  vim.keymap.set("n", "<Leader>s", ":SpellToggle<CR>", options)

  vim.api.nvim_create_user_command("QuickFixToggle", toggle_quick_fix, {})
  vim.keymap.set("n", "<Leader>q", ":QuickFixToggle<CR>", options)
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
