return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap
		local border = "rounded"

		-- Transparent background untuk floating windows
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

		-- Diagnostic config (Neovim 0.11+/0.12)
		vim.diagnostic.config({
			virtual_text = true,
			float = { border = border },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "󰠠",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		-- Keymaps saat LSP attach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- =============================================
		-- MIGRASI KE vim.lsp.config (lspconfig v3.0.0)
		-- =============================================

		-- Default capabilities untuk semua server
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Svelte
		vim.lsp.config("svelte", {
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		})

		-- GraphQL
		vim.lsp.config("graphql", {
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		-- Emmet
		vim.lsp.config("emmet_ls", {
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
				"php",
				"blade",
			},
		})

		-- Lua LS
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
				},
			},
		})

		-- Intelephense (PHP)
		vim.lsp.config("intelephense", {
			root_dir = function(fname)
				return vim.fs.root(fname, { "composer.json", ".git" }) or vim.fn.getcwd()
			end,
			settings = {
				intelephense = {
					files = { maxSize = 5000000 },
					environment = { phpVersion = "8.2" },
				},
			},
		})

		-- HTML
		vim.lsp.config("html", {
			filetypes = { "html", "blade", "php" },
		})

		-- Enable semua server yang sudah diinstall mason
		-- vim.lsp.enable() menggantikan mason_lspconfig.setup_handlers
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			handlers = {
				function(server_name)
					-- ts_ls adalah nama baru untuk tsserver
					if server_name == "tsserver" then
						server_name = "ts_ls"
					end
					vim.lsp.enable(server_name)
				end,
			},
		})

		-- Docker Compose LSP (manual, tidak lewat mason)
		vim.api.nvim_create_autocmd("BufRead", {
			pattern = { "docker-compose*.yml", "docker-compose*.yaml", "compose.yml", "compose.yaml" },
			callback = function()
				vim.lsp.start({
					name = "docker-compose-language-service",
					cmd = { "docker-compose-langserver", "--stdio" },
				})
			end,
		})
	end,
}
