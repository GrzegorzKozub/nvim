local M = {}

local function toggle(kind, open, close)
  for _, win in pairs(vim.fn.getwininfo()) do
    if win[kind] == 1 then
      ---@diagnostic disable-next-line: param-type-mismatch
      pcall(vim.cmd, close)
      return
    end
  end
  ---@diagnostic disable-next-line: param-type-mismatch
  pcall(vim.cmd, open)
end

function M.config()
  local options = { noremap = true, silent = true }

  vim.keymap.set('v', '<bs>', 'd', options)

  vim.keymap.set('n', '<c-a>', 'ggVG', options)

  vim.keymap.set('v', '<c-c>', '"+y', options)
  vim.keymap.set('v', '<c-x>', '"+x', options) -- conflicts with tmux
  vim.keymap.set({ 'n', 'v', 'x' }, '<C-V>', '"+gP', options)
  vim.keymap.set('i', '<C-V>', '<esc>:set paste<cr>a<c-r>+<esc>:set nopaste<cr>a', { noremap = true })
  vim.keymap.set('c', '<C-V>', '<c-r>+', { noremap = true })

  vim.api.nvim_create_user_command('Q', 'q', {})
  vim.api.nvim_create_user_command('W', 'w', {})

  vim.api.nvim_create_user_command('HlsearchOff', 'nohlsearch', {})
  vim.keymap.set('n', '<leader>h', ':HlsearchOff<cr>', options)

  vim.api.nvim_create_user_command('ListToggle', 'set list!', {})
  vim.keymap.set('n', '<leader>i', ':ListToggle<cr>', options)

  vim.api.nvim_create_user_command('LocationListToggle', function()
    toggle('loclist', 'lopen', 'lclose')
  end, {})
  vim.keymap.set('n', '<leader>l', ':LocationListToggle<cr>', options)

  vim.api.nvim_create_user_command('QuickFixToggle', function()
    toggle('quickfix', 'copen', 'cclose')
  end, {})
  vim.keymap.set('n', '<leader>q', ':QuickFixToggle<cr>', options)

  vim.api.nvim_create_user_command('RelativeNumberToggle', 'set relativenumber!', {})
  vim.keymap.set('n', '<leader>r', ':RelativeNumberToggle<cr>', options)

  vim.api.nvim_create_user_command('SpellToggle', 'set spell!', {})
  vim.keymap.set('n', '<leader>s', ':SpellToggle<cr>', options)

  vim.api.nvim_create_user_command('WrapToggle ', 'set wrap! linebreak! nolist', {})
  vim.keymap.set('n', '<leader>w', ':WrapToggle<cr>', options)

  -- netrw
  vim.keymap.set('n', '<leader>e', ':Explore<cr>', options)
end

return M
