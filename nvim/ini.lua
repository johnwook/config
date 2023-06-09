-- lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- FZF
  { "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  -- Color theme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- Status / Bar
  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  "lewis6991/gitsigns.nvim",
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons"} },
  "rcarriga/nvim-notify",
  -- Editor
  { "echasnovski/mini.nvim", version = "*" },
})

-- Plugin specific configurations
vim.cmd.colorscheme "catppuccin"
require("gitsigns").setup()
require("lualine").setup({
  options = {
    theme = "catppuccin"
  }
})

vim.notify = require("notify")
-- mini.nvim
require("mini.ai").setup()
require("mini.animate").setup()
require("mini.basics").setup()
require("mini.bracketed").setup()
require("mini.completion").setup()
require("mini.cursorword").setup()
require("mini.indentscope").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.tabline").setup()
require("mini.trailspace").setup()

-- Vim settings

