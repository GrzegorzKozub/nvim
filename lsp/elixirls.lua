return {
  cmd = { (os.getenv 'MASON') .. '/packages/elixir-ls/language_server.sh' },
  filetypes = { 'elixir' },
  root_markers = { '.formatter.exs', '.git', 'mix.exs' },
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
}
