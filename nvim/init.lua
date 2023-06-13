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

vim.g.coq_settings = { auto_start = "shut-up" }
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
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  { "ggandor/leap.nvim", dependencies = { "tpope/vim-repeat" } },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end
  },
  -- LSP
  { "williamboman/mason.nvim", build = ":MasonUpdate" },
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  { "folke/neodev.nvim", opts = {} },
  { "ms-jpq/coq_nvim", branch = "coq" },
  { "ms-jpq/coq.artifacts", branch = "artifacts" },
  { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  "jose-elias-alvarez/typescript.nvim",
})

-- Plugin specific configurations
vim.cmd.colorscheme "tokyonight"
vim.notify = require("notify")
require("fzf-lua").setup({
  lsp = {
    -- make lsp requests synchronous so they work with null-ls
    async_or_timeout = 3000,
  },
})
require("gitsigns").setup()
require("lualine").setup({
  options = {
    theme = "tokyonight"
  }
})
-- mini.nvim
require("mini.ai").setup()
require("mini.animate").setup()
require("mini.basics").setup()
require("mini.bracketed").setup()
require("mini.cursorword").setup()
require("mini.indentscope").setup()
require("mini.pairs").setup()
require("mini.tabline").setup()
require("mini.trailspace").setup()
require("which-key").setup()
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
  }
})
require("leap").add_default_mappings()
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "cssls",
    "docker_compose_language_service",
    "dockerls",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "svelte",
    "tailwindcss",
    "tsserver",
    "yamlls",
  }
})
require("neodev").setup()
local coq = require("coq")
require("mason-lspconfig").setup_handlers {
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup(coq.lsp_ensure_capabilities({}))
  end,
  ["lua_ls"] = function ()
    require("lspconfig").lua_ls.setup(coq.lsp_ensure_capabilities({
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace"
          }
        }
      }
    }))
  end,
}
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.diagnostics.commitlint,
    null_ls.builtins.diagnostics.alex,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.golines,
    require("typescript.extensions.null-ls.code-actions"),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})

-- Keymaps
-- lsp config
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
-- trouble.nvim
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
-- fzf lua
vim.keymap.set("n", "<C-p>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })

-- Vim settings
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

vim.g.python3_host_prog = "/Users/johnwook/.asdf/installs/python/3.10.11/bin/python3"
vim.g.node_host_prog = "/Users/johnwook/.asdf/installs/nodejs/18.16.0/bin/neovim-node-host"
