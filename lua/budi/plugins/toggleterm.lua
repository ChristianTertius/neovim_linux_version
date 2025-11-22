return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15, -- Sedikit lebih besar untuk output yang lebih jelas
			open_mapping = [[<c-\>]],
			shade_filetypes = {},
			shade_terminals = false, -- Disable shading untuk performa
			shading_factor = 1,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true, -- Persist terminal mode
			direction = "horizontal",
			close_on_exit = false, -- Jangan auto close agar bisa lihat output
			shell = "zsh",
			-- Tambahkan environment variables untuk optimasi
			env = {
				TERM = "xterm-256color",
				-- Untuk Go, set GOCACHE jika belum ada
				GOCACHE = vim.fn.expand("~/.cache/go-build"),
			},
			float_opts = {
				border = "curved",
				winblend = 0, -- Disable transparency untuk performa
				width = math.floor(vim.o.columns * 0.8),
				height = math.floor(vim.o.lines * 0.8),
			},
			winbar = {
				enabled = false,
			},
			-- Tambahkan auto scroll untuk output panjang
			auto_scroll = true,
		})

		-- Fungsi khusus untuk Go development
		local Terminal = require("toggleterm.terminal").Terminal

		-- Terminal khusus untuk Go
		local go_terminal = Terminal:new({
			cmd = "pwsh",
			direction = "horizontal",
			size = 15,
			close_on_exit = false,
			-- Optimasi untuk Go
			env = {
				GOCACHE = vim.fn.expand("~/.cache/go-build"),
				GOPATH = vim.fn.expand("~/go"),
			},
		})

		-- Fungsi untuk run Go dengan optimasi
		function _G.go_run()
			go_terminal:toggle()
			-- Kirim command dengan optimasi
			go_terminal:send("go run -ldflags='-s -w' main.go")
		end

		-- Terminal floating untuk quick commands
		local float_terminal = Terminal:new({
			direction = "float",
			float_opts = {
				border = "curved",
				winblend = 0,
				width = math.floor(vim.o.columns * 0.9),
				height = math.floor(vim.o.lines * 0.9),
			},
			close_on_exit = false,
		})

		function _G.toggle_float_terminal()
			float_terminal:toggle()
		end

		-- Terminal floating untuk Lazygit
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			float_opts = {
				border = "curved",
				winblend = 0,
				width = math.floor(vim.o.columns * 1),
				height = math.floor(vim.o.lines * 1),
			},
			close_on_exit = true,
		})

		function _G.toggle_lazygit()
			lazygit:toggle()
		end

		-- Key mappings untuk optimasi workflow
		vim.keymap.set("n", "<leader>gr", "<cmd>lua go_run()<CR>", { desc = "Go Run Optimized" })
		vim.keymap.set("n", "<leader>tt", "<cmd>lua toggle_float_terminal()<CR>", { desc = "Float Terminal" })
		vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
		vim.keymap.set("n", "<leader>lg", "<cmd>lua toggle_lazygit()<CR>", { desc = "Lazygit (Float)" })
	end,
}
