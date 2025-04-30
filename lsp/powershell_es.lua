return {
  bundle_path = vim.fn.stdpath 'data' .. '/mason/packages/powershell-editor-services/',
  settings = {
    powershell = {
      -- https://github.com/PowerShell/PowerShellEditorServices/blob/bbf3dcaebb19c2afe253ec4fd8cefb22ed3dfbe6/src/PowerShellEditorServices/Services/Workspace/LanguageServerSettings.cs
      codeFormatting = { Preset = 'OTBS' },
    },
  },
}
