return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
		config = function()

			local highlight = { "iblHighlighted" }
			local hooks = require "ibl.hooks"
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
					vim.api.nvim_set_hl(0, "iblHighlighted", { fg = "#ddc7a1" })
			end)
			require("ibl").setup {
				indent = {
					-- highlight = highlight,
					char = '│'
				},
				scope = {
					highlight = highlight,
					enabled = true
				}
			}
		end
	},
	{
		'Wansmer/treesj',
		keys = { '<space>m', _, _ },
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('treesj').setup({})
		end,
	},
	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {
						config = {
							icons = {
								heading = {
									icons = { "◉", "▶", "◎", "◉", "▶", "◎" },
								}
							}
						}
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/notes/neorg"
							},
							default_workspace = "notes"
						}
					},
					["core.export"] = {},
				}
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lua"
		},
		config = function()

			local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip/loaders/from_vscode").lazy_load()
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = {
					completeopt = "menu,menuone,noselect",
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
							-- elseif luasnip.expand_or_locally_jumpable() then
							-- 	luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
							-- elseif luasnip.locally_jumpable(-1) then
							-- 	luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "nvim_lua" },
					{ name = "buffer" },
					{ name = "calc" },
				},
				window = {
					completion = {
						-- border = border,
						-- scrollbar = "║",
					},
					documentation = {
						border = border,
						scrollbar = "║",
					},
				},
				formatting = {
					-- fields = { "kind", "menu", "abbr" },
					format = function(entry, vim_item)
						local kind_icons = {
							Text = "",
							Method = "",
							Function = "󰡱",
							Constructor = "",
							Field = "󰽏",
							Variable = "",
							Class = "",
							Interface = "",
							Module = "",
							Property = "",
							Unit = "󰚯",
							Value = "󰰵",
							Enum = "",
							Keyword = "",
							Snippet = "",
							Color = "",
							File = "",
							Reference = "",
							Folder = "",
							EnumMember = "",
							Constant = "",
							Struct = "פּ",
							Event = "",
							Operator = "",
							TypeParameter = "",
						}
						vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
						vim_item.menu = ({
							buffer = "[BUF]",
							nvim_lsp = "[LSP]",
							nvim_lua = "[API]",
							path = "[PATH]",
							luasnip = "[SNIP]",
							npm = "[NPM]",
							neorg = "[NEORG]",
						})[entry.source.name]
						return vim_item
					end,
				},
			})

		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Autoformatting
			"stevearc/conform.nvim",
		},
		config = function()
			require("neodev").setup({
				-- library = {
					--   plugins = { "nvim-dap-ui" },
					--   types = true,
					-- },
				})

				local capabilities = nil
				if pcall(require, "cmp_nvim_lsp") then
					capabilities = require("cmp_nvim_lsp").default_capabilities()
				end

				local lspconfig = require("lspconfig")

				local servers = {
					rust_analyzer = {},
					bashls = {},
					-- asm_ls = {},
					denols = {},
					-- pyright = {},
					lua_ls = {
						checkThirdParty = false,
						telemetry = { enable = false },
						library = {
							"/home/adi/.local/share/nvim/mason/packages/lua-language-server/libexec/meta/3rd/love2d/library",
							-- "${3rd}/love2d/library",
						},
						filetypes = { "lua" },
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
								diagnostics = {
									globals = { "vim" },
								},
							},
						},
					},
					clangd = {
						init_options = { clangdFileStatus = true },
						filetypes = { "c", "cpp", },
					},

					-- htmx = {},

					-- ltex = {},
					jdtls = {},
					ast_grep = {
						default_config = {
							single_file_support = true,
						}
					},
					gopls = {},
					biome = {
						default_config = {
							single_file_support = true,
						}
					},
					emmet_ls = {},
					html = {},
					cssls = {},
					pylsp = {},
					pyright = {},
					verible = {},
				}

				local default_diagnostic_config = {
					signs = {
						text = {
							-- [vim.diagnostic.severity.ERROR] = '',
							-- [vim.diagnostic.severity.WARN] = '',
							-- [vim.diagnostic.severity.INFO] = '',
							-- [vim.diagnostic.severity.HINT] = ''
							-- [vim.diagnostic.severity.ERROR] = '',
							-- [vim.diagnostic.severity.WARN] = '',
							-- [vim.diagnostic.severity.INFO] = '',
							-- [vim.diagnostic.severity.HINT] = ''
							[vim.diagnostic.severity.ERROR] = '>>',
							[vim.diagnostic.severity.WARN] = '>>',
							[vim.diagnostic.severity.INFO] = '>>',
							[vim.diagnostic.severity.HINT] = '>>'
						}
					},

					virtual_text = true,
					update_in_insert = false,
					underline = true,
					severity_sort = true,
					open_float = {
						enable = true,
					},
					float = {
						enable = true,
						focusable = true,
						style = "minimal",
						border = "rounded",
						source = "always",
						header = "",
						prefix = "",
					},
				}
				vim.diagnostic.config(default_diagnostic_config)

				for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
					vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
				end

				vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
				vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
				require("lspconfig.ui.windows").default_options.border = "rounded"

				local servers_to_install = vim.tbl_filter(function(key)
					local t = servers[key]
					if type(t) == "table" then
						return not t.manual_install
					else
						return t
					end
				end, vim.tbl_keys(servers))

				require("mason").setup()
				local ensure_installed = vim.tbl_keys(servers or {})

				vim.list_extend(ensure_installed, servers_to_install)
				require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

				for name, config in pairs(servers) do
					if config == true then
						config = {}
					end
					config = vim.tbl_deep_extend("force", {}, {
						capabilities = capabilities,
					}, config)

					lspconfig[name].setup(config)
				end

				local disable_semantic_tokens = {
					lua = true,
				}

				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(args)
						local bufnr = args.buf
						local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

						vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
						vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
						vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
						vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
						vim.keymap.set("n", "K", function()
							vim.lsp.buf.hover({ border = 'rounded' })
						end, { buffer = 0 })
						vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0 })
						vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = 0 })

						vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
						-- vim.keymap.set("n", "<space><space>", vim.lsp.buf.code_action, { buffer = 0 })

						vim.keymap.set("n", "<space>f", vim.lsp.buf.format, { buffer = 0 })

						local filetype = vim.bo[bufnr].filetype
						if disable_semantic_tokens[filetype] then
							client.server_capabilities.semanticTokensProvider = nil
						end
					end,
				})

				-- Autoformatting Setup
				require("conform").setup({
					formatters_by_ft = {
						lua = { "stylua" },
						python = { "black" },
						cpp = { "clang-format" },
						java = { "clang-format" },
						javascript = { "biome" },
						c = { "clang-format" },
						markdown = { "prettier" },
						haskell = { "fourmolu" },
						rust = { "rustfmt" },
						go = { "crlfmt" },
						verilog = { "verible" },
						html = { "htmlbeautifier" },
						css = { "prettier" },
						-- asm = { "asmfmt" },
					},
				})

		end,
	},
	{
		'nvimdev/lspsaga.nvim',
		config = function()
			require('lspsaga').setup({
				ui = {
					code_action = ""
				}
			})
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
		}
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true,
	},
};
