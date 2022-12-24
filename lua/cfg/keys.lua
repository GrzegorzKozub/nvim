local M = {}

local options = { noremap = true, silent = true }

local function neovim()
  vim.keymap.set("v", "<BS>", "d", options)
  vim.keymap.set("n", "<C-A>", "ggVG", options)
  if vim.fn.has("clipboard") then
    --vnoremap <C-C> "+y
    --vnoremap <C-X> "+x
    --map <C-V> "+gP
    --cmap <C-V> <C-R>+
    --exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
    --exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
    vim.keymap.set("v", "<C-C>", '"+y', options)
    vim.keymap.set("v", "<C-X>", '"+x', options)
    vim.keymap.set({ "n", "i", "v" }, "<C-V>", '"+gP', options)
    vim.keymap.set("c", "<C-V>", "<C-R>+", options)
  end
  vim.keymap.set("", "<C-Q>", "<C-V>", options)
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
