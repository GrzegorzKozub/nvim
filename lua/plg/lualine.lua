return {
  'nvim-lualine/lualine.nvim',
  build = function(plugin)
    local path = plugin.dir .. '/lua/lualine/themes/' .. require('cfg.my-theme').get().lualine .. '.lua'
    if vim.loop.fs_stat(path) then
      vim.loop.fs_unlink(path)
    end
  end,
  config = require('cfg.lualine').config,
  dependencies = {
    'sainnhe/gruvbox-material',
  },
}