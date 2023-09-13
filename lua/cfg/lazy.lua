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
  return {
    ui = {
      border = 'rounded',
      icons = {
        cmd = ' ',
        config = ' ',
        event = '',
        ft = ' ',
        init = ' ',
        import = ' ',
        keys = ' ',
        lazy = '󰒲 ',
        loaded = '●',
        not_loaded = '○',
        plugin = ' ',
        runtime = ' ',
        source = ' ',
        start = '',
        task = ' ',
        list = { '● ', '➜ ', '★ ', '- ' },
      },
    },
  }
end

function M.config()
  bootstrap()
  require('lazy').setup('cfg.plugins', options())
end

return M