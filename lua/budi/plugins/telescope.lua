return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						width = { padding = 0 },
						height = { padding = 0 },
						preview_width = 0.5,
					},
				},
				sorting_strategy = "ascending",
				path_display = { "absolute" },
				file_ignore_patterns = {
					"node_modules/",
					"vendor/",
					-- "storage/",
					"node_modules\\",
					".git/",
					-- "dist/",
					"%.log",
					"package%-lock%.json",
					"composer%.lock",
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						-- ["<C-t>"] = trouble_telescope.smart_open_with_trouble,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- transparent background
		vim.cmd([[
		    highlight TelescopeNormal         guibg=NONE ctermbg=NONE
		    highlight TelescopeBorder         guibg=NONE ctermbg=NONE
		    highlight TelescopePromptNormal   guibg=NONE ctermbg=NONE
		    highlight TelescopePromptBorder   guibg=NONE ctermbg=NONE
		    highlight TelescopeResultsNormal  guibg=NONE ctermbg=NONE
		    highlight TelescopeResultsBorder  guibg=NONE ctermbg=NONE
		    highlight TelescopePreviewNormal  guibg=NONE ctermbg=NONE
		    highlight TelescopePreviewBorder  guibg=NONE ctermbg=NONE
		  ]])

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<leader>fd", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		vim.keymap.set({ "n", "v" }, "<leader>fa", function()
			local text
			if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
				vim.cmd('noau normal! "vy"')
				text = vim.fn.getreg("v")
			else
				text = vim.fn.expand("<cword>")
			end
			builtin.grep_string({ search = text })
		end)

		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd using ripgrep" })
		-- keymap.set("n", "<space>fh", require("telescope.builtin").help_tags, { desc = "find helps tags" })
		keymap.set("n", "<space>fh", "<cmd>Telescope help_tags<cr>", { desc = "find helps tags" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
		keymap.set("n", "<leader>fp", "<cmd>Telescope resume<cr>", { desc = "Resume last picker" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Open buffers" })
		keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
		-- LSP navigation
		keymap.set("n", "<leader>fgd", "<cmd>Telescope lsp_definitions<cr>", { desc = "LSP definitions" })
		keymap.set("n", "<leader>fgr", "<cmd>Telescope lsp_references<cr>", { desc = "LSP references" })
		keymap.set("n", "<leader>fgi", "<cmd>Telescope lsp_implementations<cr>", { desc = "LSP implementations" })
		keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files theme=ivy<cr>")
	end,
}
