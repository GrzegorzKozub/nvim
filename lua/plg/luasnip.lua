return {
  'L3MON4D3/LuaSnip',
  build = vim.fn.has 'win32' == 0 and 'make install_jsregexp' or nil,
  lazy = true,
}
