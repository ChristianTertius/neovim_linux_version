return {
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	config = function()
		local leap = require("leap")

		-- Setup labels dulu sebelum keymaps
		leap.opts.labels = {
			"a",
			"s",
			"d",
			"f",
			"g",
			"h",
			"j",
			"k",
			"l",
			"q",
			"w",
			"e",
			"r",
			"t",
			"y",
			"u",
			"i",
			"o",
			"p",
			"z",
			"x",
			"c",
			"v",
			"b",
			"n",
			"m",
		}

		-- Hilangkan uppercase dari safe_labels juga
		leap.opts.safe_labels = {}

		-- Bidirectional leap
		vim.keymap.set({ "n", "x", "o" }, "s", function()
			leap.leap({ target_windows = { vim.fn.win_getid() } })
		end, { desc = "Leap bidirectional" })

		-- Leap ke windows lain
		vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", { desc = "Leap from windows" })
	end,
	keys = {
		{ "s", mode = { "n", "x", "o" }, desc = "Leap bidirectional" },
		{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
	},
}
