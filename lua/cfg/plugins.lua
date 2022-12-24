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
    pattern = "plugins.lua",
    callback = function()
      package.loaded["cfg.plugins"] = nil
      require("cfg.plugins").plugins(false)
      vim.cmd.PackerSync()
    end,
  })
end

function M.plugins(first_run)
  return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("lifepillar/vim-gruvbox8")
    use("lifepillar/vim-solarized8")

    use("itchyny/lightline.vim")

    use("junegunn/fzf")
    use("junegunn/fzf.vim")

    use({ "rrethy/vim-hexokinase", run = "make hexokinase" })

    use({ "sbdchd/neoformat", cmd = "Neoformat" })
    use("w0rp/ale")

    use({
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install_sync"]()
      end,
    })

    use({ "elzr/vim-json", ft = { "json" } })

    use({ "pangloss/vim-javascript", ft = { "javascript", "javascript.jsx", "typescript" } })
    use({ "leafgarland/typescript-vim", ft = { "typescript" } })
    use({ "MaxMEllon/vim-jsx-pretty", ft = { "javascript", "javascript.jsx", "typescript" } })

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
