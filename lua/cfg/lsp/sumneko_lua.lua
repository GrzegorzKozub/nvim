return {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = {
        library = {
          [vim.fn.expand '$VIMRUNTIME/lua'] = true,
          [vim.fn.stdpath 'config' .. '/lua'] = true,
          ['/home/greg/.local/share/nvim/site/pack/packer/start/nvim-cmp/lua'] = true,
          ['/home/greg/.local/share/nvim/site/pack/packer/start/lualine.nvim/lua'] = true,
        },
      },
      telemetry = { enable = false },
    },
  },
}
