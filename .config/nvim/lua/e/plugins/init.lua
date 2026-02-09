require("lazy").setup({
	"tpope/vim-commentary",
	"pocco81/auto-save.nvim",
	"tpope/vim-sleuth",
	"sbdchd/neoformat",
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "v1.*",
		opts = {
			keymap = { preset = "enter" },
			fuzzy = { implementation = "rust" },
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lazydev", "lsp", "path", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			signature = { enabled = true },
			ghost_text = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = function()
			local treesitter = require("nvim-treesitter")
			treesitter.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			treesitter.install({"python", "typescript", "lua", "tsx", "javascript", "bash"}):wait(300000)
		end,
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			vim.treesitter.language.add("python")
			vim.treesitter.language.add("typescript")
			vim.treesitter.language.add("lua")
			vim.treesitter.language.add("tsx")
			vim.treesitter.language.add("javascript")
			vim.treesitter.language.add("bash")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_rename = true,
					enable_close_on_stash = true,
					enable_close = true,
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			plugins = {
				telescope = false,
			},
			transparent = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
	},
	{
		"folke/which-key.nvim",
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
				theme = "tokyonight",
				component_separators = "|",
				section_separators = "",
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				file_ignore_patterns = { "node_modules", "venv", ".venv" },
			})
			pcall(telescope.load_extension, "fzf")
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"chrisgrieser/nvim-puppeteer",
		lazy = false,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			messages = { view = "mini", view_warn = "mini" },
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	}
}, {
	lockfile = "~/.lazy-lock.json",
})
