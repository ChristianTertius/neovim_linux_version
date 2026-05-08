return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = "",
				section_separators = "",
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {
					{
						function()
							local buf = vim.api.nvim_get_current_buf()
							local formatters = require("conform").list_formatters(buf)
							if #formatters > 0 then
								local names = {}
								for _, f in ipairs(formatters) do
									table.insert(names, f.name)
								end
								return "  " .. table.concat(names, ", ")
							end
							return ""
						end,
						color = { fg = "#a6e3a1" },
					},
					{
						function()
							local linters = require("lint").linters_by_ft[vim.bo.filetype]
							if linters then
								return "  " .. table.concat(linters, ", ")
							end
							return ""
						end,
						color = { fg = "#89b4fa" },
					},
					{
						function()
							local clients = vim.lsp.get_active_clients({ bufnr = 0 })
							if #clients == 0 then
								return ""
							end
							local names = {}
							for _, c in ipairs(clients) do
								table.insert(names, c.name)
							end
							return " " .. table.concat(names, ", ")
						end,
						color = { fg = "#f9e2af" },
					},
				},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
