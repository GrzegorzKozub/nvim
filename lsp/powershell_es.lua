local server = vim.fn.stdpath 'data' .. '/mason/packages/powershell-editor-services'
local temp = vim.fn.stdpath 'cache' .. '/powershell_es'

local cmd = ("& '%s/PowerShellEditorServices/Start-EditorServices.ps1' \z
  -BundledModulesPath '%s' -AdditionalModules @() \z
  -LogLevel Normal -LogPath '%s' \z
  -SessionDetailsPath '%s/session.json' \z
  -FeatureFlags @() \z
  -HostName nvim -HostProfileId 0 -HostVersion 1.0.0 \z
  -Stdio"):format(server, server, temp, temp)

return {
  cmd = { 'pwsh.exe', '-NoLogo', '-NoProfile', '-Command', cmd },
  filetypes = { 'ps1' },
  root_markers = { '.git' },
  settings = {
    powershell = {
      codeFormatting = { Preset = 'OTBS' },
    },
  },
}
