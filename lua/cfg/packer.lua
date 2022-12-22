local M = {}

local function bootstrap()
  local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", path })
    vim.cmd.packadd("packer.nvim")
    return true
  end
  return false
end

function M.init()
  local first_run = bootstrap()
  return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- theme
    use("itchyny/lightline.vim")
    use("lifepillar/vim-gruvbox8")
    use("lifepillar/vim-solarized8")

    if first_run then
      require("packer").sync()
    end
  end)
end

return M
