return {
  cmd = { 'jdtls' },
  filetypes = { 'java' },
  root_markers = { '.git', 'pom.xml' },
  settings = {
    -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line
    java = {
      configuration = {
        -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/issues/3303
        -- maven = { userSettings = vim.env.XDG_CONFIG_HOME .. '/maven/settings.xml' },
      },
    },
  },
}
