return {
	{
		"jwalton512/vim-blade",
		ft = "blade",
		config = function()
			require("cmp").setup.buffer({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	},
}
