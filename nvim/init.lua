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
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
  -- Status / Bar
  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  "lewis6991/gitsigns.nvim",
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons"} },
  "rcarriga/nvim-notify",
  -- Editor
  { "echasnovski/mini.nvim", version = "*" },
  { "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  -- { "folke/neodev.nvim", opts = {} }
})

-- Plugin specific configurations
vim.cmd.colorscheme "tokyonight"
require("gitsigns").setup()
require("lualine").setup({
  options = {
    theme = "tokyonight"
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
require("which-key").setup()
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  }
})
-- require("neodev").setup()

-- Vim settings
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

vim.g.python3_host_prog = "/Users/johnwook/.asdf/installs/python/3.10.11/bin/python3"
vim.g.node_host_prog = "/Users/johnwook/.asdf/installs/nodejs/18.16.0/bin/neovim-node-host"
