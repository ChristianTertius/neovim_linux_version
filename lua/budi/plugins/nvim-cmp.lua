-- return {
-- 	"hrsh7th/nvim-cmp",
-- 	event = "InsertEnter",
-- 	dependencies = {
-- 		"hrsh7th/cmp-buffer", -- source for text in buffer
-- 		"hrsh7th/cmp-path", -- source for file system paths
-- 		{
-- 			"L3MON4D3/LuaSnip",
-- 			-- follow latest release.
-- 			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
-- 			-- install jsregexp (optional!).
-- 			build = "make install_jsregexp",
-- 		},
-- 		"saadparwaiz1/cmp_luasnip", -- for autocompletion
-- 		"rafamadriz/friendly-snippets", -- useful snippets
-- 		"onsails/lspkind.nvim", -- vs-code like pictograms
-- 	},
-- 	config = function()
-- 		local cmp = require("cmp")
--
-- 		local luasnip = require("luasnip")
--
-- 		local lspkind = require("lspkind")
--
-- 		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
-- 		require("luasnip.loaders.from_vscode").lazy_load()
-- 		cmp.setup({
-- 			completion = {
-- 				completeopt = "menu,menuone,preview,noselect",
-- 			},
-- 			snippet = { -- configure how nvim-cmp interacts with snippet engine
-- 				expand = function(args)
-- 					luasnip.lsp_expand(args.body)
-- 				end,
-- 			},
-- 			mapping = cmp.mapping.preset.insert({
-- 				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
-- 				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
-- 				["<C-e>"] = cmp.mapping.abort(), -- close completion window
-- 				["<CR>"] = cmp.mapping.confirm({ select = false }),
-- 			}),
--
-- 			-- sources for autocompletion
-- 			sources = {
-- 				{ name = "nvim_lsp", priority = 2000 }, -- variabel dan fungsi dari LSP
-- 				{ name = "luasnip", priority = 1000 }, -- snippets
-- 				{ name = "buffer", priority = 500 }, -- teks dalam buffer saat ini
-- 				{ name = "path", priority = 250 }, -- jalur file sistem
-- 			},
--
-- 			-- configure lspkind for vs-code like pictograms in completion menu
-- 			formatting = {
-- 				format = lspkind.cmp_format({
-- 					maxwidth = 50,
-- 					ellipsis_char = "...",
-- 				}),
-- 			},
-- 			-- overlay = {
-- 			-- 	-- Atur opsi overlay di sini
-- 			-- 	opacity = 0.8, -- Atur nilai opasitas (0 hingga 1)
-- 			-- 	background = "transparent",
-- 			-- },
-- 		})
-- 	end,
-- }
return {
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		priority = 100,
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
			"roobert/tailwindcss-colorizer-cmp.nvim",
			{
				"supermaven-inc/supermaven-nvim",
				config = function()
					require("supermaven-nvim").setup({
						disable_inline_completion = true,
					})
				end,
			},
		},
		config = function()
			vim.opt.completeopt = { "menu", "menuone", "noselect" }
			vim.opt.shortmess:append("c")

			local lspkind = require("lspkind")
			lspkind.init({
				symbol_map = {
					Copilot = "",
				},
			})

			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

			local kind_formatter = lspkind.cmp_format({
				mode = "symbol_text",
				menu = {
					buffer = "[buf]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[api]",
					path = "[path]",
					luasnip = "[snip]",
					gh_issues = "[issues]",
					tn = "[TabNine]",
					eruby = "[erb]",
				},
			})

			-- Add tailwindcss-colorizer-cmp as a formatting source
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})

			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{
						name = "lazydev",
						-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
						group_index = 0,
					},
					-- { name = "supermaven" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
				},
				mapping = {
					["<C-n>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
						else
							cmp.complete() -- 👈 Trigger kalau belum muncul
						end
					end, { "i", "s" }),

					["<C-p>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
						else
							cmp.complete() -- 👈 Trigger kalau belum muncul
						end
					end, { "i", "s" }),
					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						}),
						{ "i", "c" }
					),
				},

				-- Enable luasnip to handle snippet expansion for nvim-cmp
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},

				formatting = {
					fields = { "abbr", "kind", "menu" },
					expandable_indicator = true,
					format = function(entry, vim_item)
						-- Lspkind setup for icons
						vim_item = kind_formatter(entry, vim_item)

						-- Tailwind colorizer setup
						vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

						return vim_item
					end,
				},

				sorting = {
					priority_weight = 2,
					comparators = {
						-- Below is the default comparitor list and order for nvim-cmp
						cmp.config.compare.offset,
						-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				window = {
					-- TODO: I don't like this at all for completion window, it takes up way too much space.
					--  However, I think the docs one could be OK, but I need to fix the highlights for it
					--
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})
		end,
	},
}
