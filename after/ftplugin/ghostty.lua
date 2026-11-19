local ftplugin = '/usr/share/nvim/site/ftplugin/ghostty.vim'

if vim.uv.fs_stat(ftplugin) then
  vim.b.did_ftplugin = nil
  vim.cmd.source(ftplugin)
end
