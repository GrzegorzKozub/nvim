return {
  cmd = { 'jdtls' },
  filetypes = { 'java' },
  root_markers = { '.git', 'pom.xml' },
  settings = {
    -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line
    java = {
      configuration = {
        maven = { userSettings = vim.env.XDG_CONFIG_HOME .. '/maven/settings.xml' },
      },
    },
  },
}
