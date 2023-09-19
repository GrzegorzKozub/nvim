local M = {}

local function bootstrap()
  local path = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(path) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      -- '--branch=stable',
      'https://github.com/folke/lazy.nvim.git',
      path,
    }
  end
  vim.opt.runtimepath:prepend(path)
end

local function options()
  local icons = require('cfg.icons').get()
  return {
    ui = {
      border = 'rounded',
      icons = {
        cmd = icons.lazy.cmd,
        config = icons.lazy.config,
        loaded = icons.package.enabled,
        not_loaded = icons.package.disabled,
        runtime = icons.lazy.vim,
        task = icons.package.pending,
        list = { '', '', '', '' },
      },
    },
  }
end

function M.config()
  bootstrap()
  require('lazy').setup('plg', options())
end

return M