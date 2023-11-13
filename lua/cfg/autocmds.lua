local M = {}

local function file_types()
  local group = vim.api.nvim_create_augroup('FileTypes', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = 'config',
    callback = function()
      vim.opt.filetype = 'confini'
    end,
    group = group,
  })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'vim',
    callback = function()
      vim.opt_local.textwidth = 0
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

local function wt_cursor()
  if vim.fn.has 'win32' == 0 then
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

  vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyUpdate',
    callback = function()
      local path = '/home/greg/.local/share/nvim/lazy/lualine.nvim/lua/lualine/themes/' .. require('cfg.theme').get().lualine .. '.lua'
      if vim.loop.fs_stat(path) then
        vim.loop.fs_unlink(path)
      end
    end,
    group = vim.api.nvim_create_augroup('Dupa1', { clear = true }),
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyUpdatePre',
    callback = function()
      local path = '/home/greg/.local/share/nvim/lazy/lualine.nvim'
local f = assert(io.popen('cd ' .. path .. ' && git reset --hard'))
  f:close()
    end,
    group = vim.api.nvim_create_augroup('Dupa', { clear = true }),
  })
end

return M