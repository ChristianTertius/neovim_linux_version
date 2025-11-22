return {
	"ThePrimeagen/harpoon",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("harpoon").setup({
			global_settings = {
				save_on_toggle = false,
				save_on_change = true,
				enter_on_sendcmd = false,
				tmux_autoclose_windows = false,
				excluded_filetypes = { "harpoon" },
				mark_branch = false,
				tabline = false,
				tabline_prefix = "   ",
				tabline_suffix = "   ",
			},
			projects = {
				-- Konfigurasi per project bisa ditambahkan di sini
			},
			menu = {
				width = math.max(math.floor(vim.api.nvim_win_get_width(0) * 0.3), 30),
				height = math.min(math.floor(vim.api.nvim_win_get_height(0) * 0.5), 25),
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			},
		})

		-- Highlight groups untuk tampilan yang lebih bagus
		vim.api.nvim_set_hl(0, "HarpoonWindow", { link = "Normal" })
		vim.api.nvim_set_hl(0, "HarpoonBorder", { fg = "#7aa2f7", bold = true })

		-- Override harpoon menu untuk menambahkan relative numbers
		local harpoon_ui = require("harpoon.ui")
		local original_toggle_quick_menu = harpoon_ui.toggle_quick_menu

		harpoon_ui.toggle_quick_menu = function(options)
			original_toggle_quick_menu(options)

			-- Tunggu sebentar sampai window Harpoon terbuka
			vim.defer_fn(function()
				local harpoon_bufnr = vim.fn.bufnr("__harpoon_files__")
				if harpoon_bufnr ~= -1 then
					local harpoon_winid = vim.fn.bufwinid(harpoon_bufnr)
					if harpoon_winid ~= -1 then
						vim.api.nvim_win_set_option(harpoon_winid, "relativenumber", true)
						vim.api.nvim_win_set_option(harpoon_winid, "number", true)
					end
				end
			end, 10)
		end
	end,
	keys = {
		-- Menu navigation
		{ "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
		{ "<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "󰛢 Show harpoon marks" },
		-- Quick navigation dengan leader
		{ "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "󰛢 Harpoon buffer 1" },
		{ "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "󰛢 Harpoon buffer 2" },
		{ "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "󰛢 Harpoon buffer 3" },
		{ "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "󰛢 Harpoon buffer 4" },
		{ "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", desc = "󰛢 Harpoon buffer 5" },
		{ "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", desc = "󰛢 Harpoon buffer 6" },
		{ "<leader>7", "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", desc = "󰛢 Harpoon buffer 7" },
		{ "<leader>8", "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", desc = "󰛢 Harpoon buffer 8" },
		{ "<leader>9", "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", desc = "󰛢 Harpoon buffer 9" },
		{ "<leader>0", "<cmd>lua require('harpoon.ui').nav_file(10)<cr>", desc = "󰛢 Harpoon buffer 10" },
	},
}
