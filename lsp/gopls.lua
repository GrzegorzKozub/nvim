return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gotmpl', 'gowork' },
  root_markers = { '.git', 'go.mod', 'go.sum', 'go.work' },
  settings = {
    gopls = {
      analyses = { shadow = true },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
