local M = {}

local function file_types()
  local group = vim.api.nvim_create_augroup('FileTypes', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = 'config',
    callback = function()
      vim.cmd.set 'filetype=confini'
    end,
    group = group,
  })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'vim',
    callback = function()
      vim.cmd.setlocal 'textwidth=0'
    end,
    group = group,
  })
end

local function last_seen_location()
  vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*',
    callback = function()
      vim.cmd [[
        if line("'\"") >= 1 && line("'\"") <= line("$") && &filetype !~# 'commit'
          exe "normal! g`\""
        endif
      ]]
    end,
    group = vim.api.nvim_create_augroup('LastSeenLocation', { clear = true }),
  })
end

local function yank_highlight()
  vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
      vim.highlight.on_yank()
    end,
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  })
end

function M.config()
  file_types()
  last_seen_location()
  yank_highlight()
end

return M
