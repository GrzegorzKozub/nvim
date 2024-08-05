local M = {}

local function toggle(kind, open, close)
  for _, win in pairs(vim.fn.getwininfo()) do
    if win[kind] == 1 then
      pcall(vim.cmd, close)
      return
    end
  end
  pcall(vim.cmd, open)
end

function M.config()
  local options = { noremap = true, silent = true }

  vim.keymap.set('n', '<c-a>', 'ggVG', options)

  vim.keymap.set('n', '<c-c>', 'V"+y', options) -- whole line
  vim.keymap.set('v', '<c-c>', '"+y', options)

  vim.keymap.set('n', '<c-x>', 'V"+x', options) -- conflicts with tmux; hit <c-x> twice
  vim.keymap.set('v', '<c-x>', '"+x', options)

  vim.keymap.set({ 'n', 'v', 'x' }, '<C-V>', '"+gP', options)
  vim.keymap.set('i', '<c-v>', '<esc>:set paste<cr>a<c-r>+<esc>:set nopaste<cr>a', { noremap = true })
  vim.keymap.set('c', '<c-v>', '<c-r>+', { noremap = true })

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
end

return M