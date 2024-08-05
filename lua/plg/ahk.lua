return {
  'GrzegorzKozub/ahk.nvim',
  cond = vim.fn.has 'win32' == 1,
  lazy = true,
  opts = { interpreter = 'AutoHotkey64.exe' },
}