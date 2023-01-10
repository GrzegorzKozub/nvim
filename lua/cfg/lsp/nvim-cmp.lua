local M = {}

function M.config()
  local loaded, plugin = pcall(require, 'cmp')
  if not loaded then
    return
  end

  plugin.setup {
    mapping = plugin.mapping.preset.insert {
      ['<tab>'] = plugin.mapping(function(fallback)
        if plugin.visible() then
          plugin.select_next_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<s-tab>'] = plugin.mapping(function(fallback)
        if plugin.visible() then
          plugin.select_prev_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = plugin.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    }),
  }
end

return M
