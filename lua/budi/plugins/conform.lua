return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			-- JavaScript/TypeScript
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },

			-- go = { "gofmt" },
			templ = { "templ" },
			html = { "prettierd", stop_after_first = true },
			css = { "prettierd", stop_after_first = true },
			lua = { "stylua" },
			php = { "intelephense" },
		},

		-- Format on save
		format_on_save = {
			timeout_ms = 200,
			lsp_fallback = true,
		},
	},
}
