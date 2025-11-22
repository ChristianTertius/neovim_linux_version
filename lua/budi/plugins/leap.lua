-- return {
-- 	"ggandor/leap.nvim",
-- 	dependencies = { "tpope/vim-repeat" },
-- 	config = function()
-- 		local leap = require("leap")
--
-- 		-- Setup labels dulu sebelum keymaps
-- 		leap.opts.labels = {
-- 			"a",
-- 			"s",
-- 			"d",
-- 			"f",
-- 			"g",
-- 			"h",
-- 			"j",
-- 			"k",
-- 			"l",
-- 			"q",
-- 			"w",
-- 			"e",
-- 			"r",
-- 			"t",
-- 			"y",
-- 			"u",
-- 			"i",
-- 			"o",
-- 			"p",
-- 			"z",
-- 			"x",
-- 			"c",
-- 			"v",
-- 			"b",
-- 			"n",
-- 			"m",
-- 		}
--
-- 		-- Hilangkan uppercase dari safe_labels juga
-- 		leap.opts.safe_labels = {}
--
-- 		-- Bidirectional leap
-- 		vim.keymap.set({ "n", "x", "o" }, "s", function()
-- 			leap.leap({ target_windows = { vim.fn.win_getid() } })
-- 		end, { desc = "Leap bidirectional" })
--
-- 		-- Leap ke windows lain
-- 		vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", { desc = "Leap from windows" })
-- 	end,
-- 	keys = {
-- 		{ "s", mode = { "n", "x", "o" }, desc = "Leap bidirectional" },
-- 		{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
-- 	},
-- }
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
}
