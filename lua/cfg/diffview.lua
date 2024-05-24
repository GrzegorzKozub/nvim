local M = {}

function M.config()
  local diffview_loaded, diffview = pcall(require, 'diffview')
  if not diffview_loaded then
    return
  end

  diffview.setup {
    enhanced_diff_hl = true,
    use_icons = false,
  }
end

return M