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

local function backspace(options)
  vim.keymap.set('n', '<bs>', 'X', options)
  vim.keymap.set('v', '<bs>', 'd', options)
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

  vim.keymap.set({ 'n', 'x' }, '<c-v>', '"+gP', options)
  vim.keymap.set({ 'c', 'i' }, '<c-v>', '<c-r>+', { noremap = true })
end

local function windows(options)
  -- <c-o> - go back
  -- <c-i> - go forward

  -- <c-w>c - close current window
  -- <c-w>q - quit current window

  vim.keymap.set('n', '<c-w><c-c>', ':quitall<cr>', options)

  vim.keymap.set('n', '<c-w>r', ':vsplit<cr>', options)
  vim.keymap.set('n', '<c-w>d', ':split<cr>', options)

  -- <c-w>left|down|up|right - activate window

  -- handled by nav on linux
  if vim.fn.has 'win32' == 1 then
    vim.keymap.set('n', '<a-left>', ':' .. vim.v.count .. 'wincmd h<cr>', options)
    vim.keymap.set('n', '<a-down>', ':' .. vim.v.count .. 'wincmd j<cr>', options)
    vim.keymap.set('n', '<a-up>', ':' .. vim.v.count .. 'wincmd k<cr>', options)
    vim.keymap.set('n', '<a-right>', ':' .. vim.v.count .. 'wincmd l<cr>', options)
  end

  -- <c-w>= - make all window sizes equal
  -- <c-w>o - close all other windows

  vim.keymap.set('n', '<esc>', ':fclose<cr>', options) -- close topmost floating window
end

local function tabs(options)
  vim.keymap.set('n', '[t', ':tabprevious<cr>', options)
  vim.keymap.set('n', ']t', ':tabnext<cr>', options)
end

local function toggles(options)
  vim.api.nvim_create_user_command('HlsearchToggle', function()
    vim.cmd 'set hlsearch!'
    vim.notify('search highlight ' .. (vim.o.hlsearch and 'enabled' or 'disabled'))
  end, {})
  vim.keymap.set('n', '<leader>h', ':HlsearchToggle<cr>', options)

  vim.api.nvim_create_user_command('ListToggle', function()
    vim.cmd 'set list!'
    vim.notify('list mode ' .. (vim.o.list and 'enabled' or 'disabled'))
  end, {})
  vim.keymap.set('n', '<leader>i', ':ListToggle<cr>', options)

  vim.api.nvim_create_user_command('LocationListToggle', function()
    toggle('loclist', 'lopen', 'lclose')
  end, {})
  vim.keymap.set('n', '<leader>l', ':LocationListToggle<cr>', options)

  vim.api.nvim_create_user_command('QuickFixToggle', function()
    toggle('quickfix', 'copen', 'cclose')
  end, {})
  vim.keymap.set('n', '<leader>q', ':QuickFixToggle<cr>', options)

  vim.api.nvim_create_user_command('RelativeNumberToggle', function()
    vim.cmd 'set relativenumber!'
    vim.notify('relative line numbers ' .. (vim.o.relativenumber and 'enabled' or 'disabled'))
  end, {})
  vim.keymap.set('n', '<leader>r', ':RelativeNumberToggle<cr>', options)

  vim.api.nvim_create_user_command('SpellToggle', function()
    vim.cmd 'set spell!'
    vim.notify('spell check ' .. (vim.o.spell and 'enabled' or 'disabled'))
  end, {})
  vim.keymap.set('n', '<leader>s', ':SpellToggle<cr>', options)

  vim.api.nvim_create_user_command('WrapToggle', function()
    vim.cmd 'set wrap! linebreak! nolist'
    vim.notify('line wrap ' .. (vim.o.wrap and 'enabled' or 'disabled'))
  end, {})
  vim.keymap.set('n', '<leader>w', ':WrapToggle<cr>', options)
end

function M.config()
  local options = { noremap = true, silent = true }
  selection(options)
  backspace(options)
  clipboard(options)
  windows(options)
  tabs(options)
  toggles(options)
end

return M
