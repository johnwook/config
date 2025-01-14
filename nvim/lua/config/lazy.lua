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
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true

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
		{ "nvim-tree/nvim-web-devicons", lazy = true },
		{
			"ibhagwan/fzf-lua",
			opts = {
				winopts = {
					treesitter = {
						enabled = true,
						fzf_colors = false,
					},
				},
			},
		},
		{ "williamboman/mason.nvim", opts = {} },
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				ensure_installed = {
					"cssls",
					"dockerls",
					"docker_compose_language_service",
					"eslint",
					"gopls",
					"graphql",
					"html",
					"jsonls",
					"ts_ls",
					"lua_ls",
					"svelte",
					"taplo",
					"tailwindcss",
					"yamlls",
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
		},
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-emoji",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-calc",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lsp-signature-help",
			},
			config = function()
				local cmp = require("cmp")
				local luasnip = require("luasnip")

				local has_words_before = function()
					if vim.bo.buftype == "prompt" then
						return false
					end
					local line, col = unpack(vim.api.nvim_win_get_cursor(0))
					return col ~= 0
						and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
				end

				cmp.setup({
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.abort(),
						["<CR>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								if luasnip.expandable() then
									luasnip.expand()
								else
									cmp.confirm({
										select = true,
									})
								end
							else
								fallback()
							end
						end),
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() and has_words_before() then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
							elseif luasnip.locally_jumpable(1) then
								luasnip.jump(1)
							else
								fallback()
							end
						end, { "i", "s" }),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.locally_jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
					}),
					sources = cmp.config.sources({
						{ name = "copilot" },
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
					}, {
						{ name = "nvim_lsp_signature_help" },
						{ name = "buffer" },
						{ name = "emoji" },
						{ name = "path" },
						{ name = "calc" },
					}),
				})

				cmp.setup.cmdline("/", {
					mapping = cmp.mapping.preset.cmdline(),
					sources = {
						{ name = "buffer" },
					},
				})

				cmp.setup.cmdline(":", {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = "path" },
					}, {
						{
							name = "cmdline",
							option = {
								ignore_cmds = { "Man", "!" },
							},
						},
					}),
				})
			end,
		},
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					"lazy.nvim",
					{ path = "LazyVim", words = { "LazyVim" } },
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
				integrations = {
					cmp = true,
				},
			},
		},
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
					javascript = { "prettierd", "prettier", stop_after_first = true },
					svelte = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					graphql = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettierd", "prettier", stop_after_first = true },
					go = { "gofumpt", "goimports", "golines" },
				},
				-- Set default options
				default_format_opts = {
					lsp_format = "fallback",
				},
				-- Set up format-on-save
				format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
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
		{
			"kylechui/nvim-surround",
			version = "*", -- Use for stability; omit to use `main` branch for the latest features
			event = "VeryLazy",
			opts = {},
		},
		{ "lewis6991/gitsigns.nvim", opts = {} },
		{ "stevearc/dressing.nvim", opts = {} },
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("copilot").setup({
					panel = { enabled = false },
					suggestion = { enabled = false },
				})
			end,
		},
		{ "zbirenbaum/copilot-cmp", opts = {} },
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
			opts = {},
		},
		{ "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} },
	},
	-- automatically check for plugin updates
	checker = { enabled = true },
})

local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
	vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({})
	end,
})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		disable = function(_, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	end,
})

-- Fzflua
vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "Fzf Buffers" })
vim.keymap.set("n", "<leader>p", require("fzf-lua").files, { desc = "Fzf Files" })
vim.keymap.set("n", "<leader>g", require("fzf-lua").grep, { desc = "Fzf Grep" })
vim.keymap.set("n", "<leader>r", require("fzf-lua").resume, { desc = "Fzf Resume" })

-- autopairs
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
