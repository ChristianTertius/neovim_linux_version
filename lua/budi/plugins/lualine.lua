return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {
					-- Formatter info
					{
						function()
							local buf = vim.api.nvim_get_current_buf()
							local ft = vim.bo[buf].filetype
							local formatters = require("conform").list_formatters(buf)
							if #formatters > 0 then
								local names = {}
								for _, formatter in ipairs(formatters) do
									table.insert(names, formatter.name)
								end
								return "  " .. table.concat(names, ", ")
							end
							return ""
						end,
						color = { fg = "#a6e3a1" },
					},
					-- Linter info (aman jika plugin lint tidak dimuat)
					{
						function()
							local ok, lint = pcall(require, "lint")
							if not ok or not lint then
								return ""
							end
							local buf = vim.api.nvim_get_current_buf()
							local linters = lint.linters_by_ft[vim.bo[buf].filetype]
							if linters then
								return "  " .. table.concat(linters, ", ")
							end
							return ""
						end,
						color = { fg = "#89b4fa" },
					},
					-- LSP info
					{
						function()
							local clients = vim.lsp.get_clients({ buffer = 0 })
							if #clients == 0 then
								return ""
							end
							local names = {}
							for _, client in ipairs(clients) do
								table.insert(names, client.name)
							end
							return " " .. table.concat(names, ", ")
						end,
						color = { fg = "#f9e2af" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
