local M = {}

local function file_types()
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = 'config',
    callback = function()
      vim.opt.filetype = 'confini'
    end,
    group = vim.api.nvim_create_augroup('FileTypes', { clear = true }),
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

local function wt_cursor()
  if vim.fn.has 'win32' == 0 or not os.getenv 'WT_SESSION' then
    return
  end
  vim.api.nvim_create_autocmd('VimLeave', {
    pattern = '*',
    callback = function()
      -- https://github.com/neovim/neovim/issues/4396
      vim.opt.guicursor = ''
      vim.fn.chansend(vim.v.stderr, '\x1b[ q')
    end,
    group = vim.api.nvim_create_augroup('WindowsTerminalCursor', { clear = true }),
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
  wt_cursor()
  yank_highlight()
end

return M