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

local function auto_commands()
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "packer.lua",
    callback = function()
      package.loaded["cfg.packer"] = nil
      require("cfg.packer").plugins(false)
      vim.cmd.PackerSync()
    end,
  })
end

function M.plugins(first_run)
  return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- theme
    use("lifepillar/vim-gruvbox8")
    use("lifepillar/vim-solarized8")

    -- lightline
    use("itchyny/lightline.vim")

    -- ale
    use("w0rp/ale")

    if first_run then
      require("packer").sync()
    end
  end)
end

function M.init()
  local first_run = bootstrap()
  auto_commands()
  M.plugins(first_run)
end

return M
