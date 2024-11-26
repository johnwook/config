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
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{ "lewis6991/gitsigns.nvim" },
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ "rcarriga/nvim-notify" },
	-- Utility
	{ "echasnovski/mini.nvim", version = false },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{ "ggandor/leap.nvim" },
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{ "folke/neodev.nvim", opts = {} },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{ "windwp/nvim-ts-autotag" },
	-- Syntax
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	-- LSP & formatter
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			{ "ms-jpq/coq_nvim", branch = "coq" },
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },
		},
		init = function()
			vim.g.coq_settings = {
				auto_start = "shut-up",
				keymap = { recommended = false },
			}
		end,
	},
	{ "mhartington/formatter.nvim" },
	-- Copilot
	"github/copilot.vim",
})

-- Plugin specific configurations
vim.cmd([[colorscheme tokyonight-storm]])
require("gitsigns").setup()
require("lualine").setup({
	options = {
		theme = "tokyonight",
	},
})
vim.notify = require("notify")
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
require("leap").create_default_mappings()
require("neodev").setup()
require("nvim-ts-autotag").setup()

-- mini.nvim
require("mini.ai").setup()
require("mini.animate").setup()
require("mini.basics").setup()
require("mini.bracketed").setup()
require("mini.comment").setup()
require("mini.cursorword").setup()
require("mini.indentscope").setup()
require("mini.tabline").setup()
require("mini.trailspace").setup()

-- LSP & formatter
require("mason").setup()
require("mason-lspconfig").setup({
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
})
local coq = require("coq")
local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup(coq.lsp_ensure_capabilities({}))
	end,
	["lua_ls"] = function()
		lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities({
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		}))
	end,
})
require("formatter").setup({
	filetype = {
		css = {
			require("formatter.filetypes.css").prettier,
		},
		html = {
			require("formatter.filetypes.html").prettier,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},
		json = {
			require("formatter.filetypes.json").prettier,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		postcss = {
			require("formatter.filetypes.css").prettier,
		},
		svelte = {
			require("formatter.filetypes.svelte").prettier,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettier,
		},
		go = {
			require("formatter.filetypes.go").goimports,
			require("formatter.filetypes.go").golines,
		},
		graphql = {
			require("formatter.filetypes.graphql").prettier,
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

-- Autopairs
local remap = vim.api.nvim_set_keymap
local npairs = require("nvim-autopairs")

npairs.setup({ map_bs = false, map_cr = false })

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap("i", "<esc>", [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap("i", "<c-c>", [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap("i", "<tab>", [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap("i", "<s-tab>", [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils = {}

MUtils.CR = function()
	if vim.fn.pumvisible() ~= 0 then
		if vim.fn.complete_info({ "selected" }).selected ~= -1 then
			return npairs.esc("<c-y>")
		else
			return npairs.esc("<c-e>") .. npairs.autopairs_cr()
		end
	else
		return npairs.autopairs_cr()
	end
end
remap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

MUtils.BS = function()
	if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
		return npairs.esc("<c-e>") .. npairs.autopairs_bs()
	else
		return npairs.autopairs_bs()
	end
end
remap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	end,
})

-- Formatter
vim.keymap.set("n", "<leader>f", "<cmd>Format<cr>")
vim.keymap.set("n", "<leader>F", "<cmd>FormatWrite<cr>")
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})

-- Vim settings
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

vim.g.python3_host_prog = "/Users/johnwook/.asdf/installs/python/3.10.11/bin/python3"
vim.g.node_host_prog = "/Users/johnwook/.asdf/installs/nodejs/20.12.2/bin/neovim-node-host"
