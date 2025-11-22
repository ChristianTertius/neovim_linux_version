return {
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			-- Setup dengan filetypes kosong (tidak aktif otomatis)
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

			-- Keybinding untuk toggle
			vim.keymap.set("n", "<leader>tc", "<cmd>ColorizerToggle<cr>", { desc = "Toggle Colorizer" })
		end,
	},
}
