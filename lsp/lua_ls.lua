return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.git', '.luacheckrc', '.luarc.json', '.stylua.toml' },
  settings = {
    Lua = {
      hint = { enable = true, setType = true },
      runtime = { version = 'LuaJIT' },
      workspace = { checkThirdParty = false },
    },
  },
}
