return {
	"kristijanhusak/vim-dadbod-completion",
	dependencies = {
		"tpope/vim-dadbod",
		"kristijanhusak/vim-dadbod-ui",
	},
	config = function()
		-- Setting lebar drawer Dadbod UI
		vim.g.db_ui_winwidth = 30 -- ubah angka sesuai keinginan
		vim.g.db_ui_win_position = "left"
		-- Setting lainnya (opsional)
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_show_database_icon = 1
		vim.g.db_ui_show_stored_procedures = 1
		-- Setup nvim-cmp untuk dadbod
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "sql", "mysql", "plsql" },
			callback = function()
				require("cmp").setup.buffer({
					sources = {
						{ name = "vim-dadbod-completion" },
						{ name = "buffer" },
					},
				})
			end,
		})
	end,
}
