return {
  'GrzegorzKozub/ahk.nvim',
  cond = not vim.g.vscode and vim.fn.has 'win32' == 1,
  lazy = true,
  opts = { interpreter = 'AutoHotkey64.exe' },
}