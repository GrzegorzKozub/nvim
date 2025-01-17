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

local function selection(options)
  vim.keymap.set('n', '<c-a>', 'ggVG', options) -- select all
end

local function clipboard(options)
  local copy = '"+y'
  local cut = '"+x'
  local whole_line = 'V'

  vim.keymap.set('x', '<c-c>', copy, options)
  vim.keymap.set('n', '<c-c>', whole_line .. copy, options)

  vim.keymap.set('x', '<c-x>', cut, options) -- hit <c-x> twice in tmux
  vim.keymap.set('n', '<c-x>', whole_line .. cut, options)

  vim.keymap.set('x', 'p', 'P', options) -- P doesn't replace register content

  vim.keymap.set({ 'x', 'n' }, '<c-v>', '"+gP', options)
  vim.keymap.set(
    'i',
    '<c-v>',
    '<esc>:set paste<cr>a<c-r>+<esc>:set nopaste<cr>a',
    { noremap = true }
  )
  vim.keymap.set('c', '<c-v>', '<c-r>+', { noremap = true })
end

local function windows(options)
  vim.keymap.set('n', '<esc>', ':fclose<cr>', options) -- close topmost floating window
end

local function tabs(options)
  vim.keymap.set('n', '[t', ':tabprevious<cr>', options)
  vim.keymap.set('n', ']t', ':tabnext<cr>', options)
end

local function toggles(options)
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

function M.config()
  local options = { noremap = true, silent = true }
  selection(options)
  clipboard(options)
  windows(options)
  tabs(options)
  toggles(options)
end

return M
