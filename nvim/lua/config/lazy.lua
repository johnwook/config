-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.lua_interpreter_path = "/Users/johnwook/.asdf/installs/lua/5.1/bin/lua"
vim.g.node_host_prog = "/Users/johnwook/.asdf/installs/nodejs/22.12.0/bin/neovim-node-host"
vim.g.python3_host_prog = "/Users/johnwook/.asdf/installs/python/3.13.1/bin/python"

-- Vim settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			"folke/tokyonight.nvim",
			lazy = false, -- make sure we load this during startup if it is your main colorscheme
			priority = 1000, -- make sure to load this before all the other start plugins
			config = function()
				-- load the colorscheme here
				vim.cmd([[colorscheme tokyonight-storm]])
			end,
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		{ "nvim-tree/nvim-web-devicons", opts = {} },
		{ "ibhagwan/fzf-lua", opts = {} },
		{ "williamboman/mason.nvim", opts = {} },
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true })
					end,
					mode = "",
					desc = "Format buffer",
				},
			},
			-- This will provide type hinting with LuaLS
			---@module "conform"
			---@type conform.setupOpts
			opts = {
				-- Define your formatters
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier", stop_after_first = true },
				},
				-- Set default options
				default_format_opts = {
					lsp_format = "fallback",
				},
				-- Set up format-on-save
				format_on_save = { timeout_ms = 500 },
				-- Customize formatters
				formatters = {
					shfmt = {
						prepend_args = { "-i", "2" },
					},
				},
			},
		},
		{ "nvim-lualine/lualine.nvim", opts = { theme = "tokyonight-storm" } },
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
		{
			"folke/flash.nvim",
			event = "VeryLazy",
			---@type Flash.Config
			opts = {},
      -- stylua: ignore
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
		},
		{
			"folke/snacks.nvim",
			priority = 1000,
			lazy = false,
			---@type snacks.Config
			opts = {
				indent = {},
				notifier = {},
				scroll = {},
				statuscolumn = {},
				toggle = {},
				words = {},
			},
			keys = {
				{
					"<leader>lg",
					function()
						Snacks.lazygit()
					end,
					desc = "Lazygit",
				},
				{
					"]]",
					function()
						Snacks.words.jump(vim.v.count1)
					end,
					desc = "Next Reference",
					mode = { "n", "t" },
				},
				{
					"[[",
					function()
						Snacks.words.jump(-vim.v.count1)
					end,
					desc = "Prev Reference",
					mode = { "n", "t" },
				},
			},
		},
		{ "folke/todo-comments.nvim", opts = {} },
		{ "nvim-lua/plenary.nvim", lazy = true },
		k("kylechui/nvim-surround"),
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		opts = {},
		k,
	},
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- Fzflua
vim.keymap.set("n", "<leader>p", require("fzf-lua").files, { desc = "Fzf Files" })
vim.keymap.set("n", "<leader>g", require("fzf-lua").grep, { desc = "Fzf Grep" })
