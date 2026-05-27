return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
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
