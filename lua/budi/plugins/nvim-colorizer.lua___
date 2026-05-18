return {
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" }, -- lazy load saat buka file
		keys = {
			{ "<leader>tc", "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" },
		},
		config = function()
			require("colorizer").setup({}, {
				RGB = true,
				RRGGBB = true,
				names = true,
				RRGGBBAA = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
				mode = "background",
			})
		end,
	},
}
