local telescope = require("configs.telescope")
local lspconfig = require("configs.lspconfig")
local treesitter = require("configs.treesitter")
local _cmp = require("configs.nvim-cmp")

require("lazy").setup({

	-- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    "tpope/vim-surround",
  },

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<A-i>]],
				direction = "float",
			})
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = { { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
	},

	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("oil").setup({
				delete_to_trash = true,
			})
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		lazy = false,
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>hp", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Open Harpoon list" })
			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end, { desc = "Harpoon Append" })
			vim.keymap.set("n", "<leader>1", function()
				harpoon:list():select(1)
			end, { desc = "Harpoon 1st buffer" })
			vim.keymap.set("n", "<leader>2", function()
				harpoon:list():select(2)
			end, { desc = "Harpoon 2nd buffer" })
			vim.keymap.set("n", "<leader>3", function()
				harpoon:list():select(3)
			end, { desc = "Harpoon 3rd buffer" })
			vim.keymap.set("n", "<leader>4", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon 4th buffer" })
		end,
	},

	{
		"MunifTanjim/prettier.nvim",
		lazy = false,
		config = function()
			local prettier = require("prettier")
			prettier.setup({ bin = "prettier" }) -- or `'prettierd'` (v0.23.3+)
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		-- Optional dependency
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup({})
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_foreground = "mix"
			vim.g.gruvbox_material_enable_italic = false
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_visual = "reverse"
			vim.g.gruvbox_material_enable_bold = 1

			vim.cmd.colorscheme("gruvbox-material")
		end,
	},

	telescope,
	lspconfig,
	_cmp,
	treesitter,

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = "gruvbox-material",
					component_separators = "",
					section_separators = "",
				},
			})
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("which-key").setup()

			-- require("which-key").add({
			-- 	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			-- 	["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			-- 	["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			-- 	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			-- 	["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			-- 	["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
			-- 	["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
			-- })

      require("which-key").add({
        { "<leader>c", group = "[C]ode" },
        { "<leader>c_", hidden = true },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>d_", hidden = true },
        { "<leader>h", group = "Git [H]unk" },
        { "<leader>h_", hidden = true },
        { "<leader>r", group = "[R]ename" },
        { "<leader>r_", hidden = true },
        { "<leader>s", group = "[S]earch" },
        { "<leader>s_", hidden = true },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>t_", hidden = true },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>w_", hidden = true },
      })

			-- require("which-key").add({
			-- 	["<leader>h"] = { "Git [H]unk" },
			-- }, { mode = "v" })


			require("which-key").add({
				{ "<leader>h", group = "Git [H]unk" },
			}, { mode = "v" })


		end,
	},
})
