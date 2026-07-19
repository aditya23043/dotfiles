vim.g.mapleader = " "
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"
-- vim.opt.winborder = "single"
vim.opt.swapfile = false
vim.opt.completeopt = "menuone,noinsert,noselect,preview"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.relativenumber = true
vim.opt.laststatus = 2
vim.opt.cursorline = true

vim.deprecate = function() end -- in order to prevent vim keyword warnings

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	callback = function()
		vim.opt.relativenumber = false
	end
})

vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		vim.opt.relativenumber = true
	end
})

vim.pack.add({

	{ src = "https://github.com/MunifTanjim/nui.nvim" },        
	{ src = "https://github.com/nvim-lua/plenary.nvim" },        
	{ src = "https://github.com/kawre/leetcode.nvim" },

	{ src = "https://github.com/if-not-nil/bark" },
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	{ src = "https://github.com/sainnhe/gruvbox-material" },
	{ src = "https://github.com/Wansmer/treesj" },
	{ src = "https://github.com/nvimdev/lspsaga.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-flutter/flutter-tools.nvim" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
})

vim.lsp.enable({ "lua_ls", "clangd", "kotlin_lsp", "gradle_ls", "jdtls", "tinymist" })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			}
		}
	}
})

vim.cmd.colorscheme "bark"
-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = "#343434" })
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#41423d", bold = true })

vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<Esc>', ':nohl<CR>')
vim.keymap.set('n', 'K', vim.diagnostic.open_float)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
-- vim.keymap.set('n', '<leader><leader>', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<leader><leader>', '<cmd>Lspsaga code_action<CR>')
vim.keymap.set('n', '<leader>r', "<cmd>Pick grep_live<CR>")
vim.keymap.set('n', '<leader>f', "<cmd>Pick files<CR>")
vim.keymap.set('n', '<leader>b', "<cmd>Pick buffers<CR>")
vim.keymap.set('n', '<leader>t', "<cmd>Lspsaga term_toggle<CR>")
vim.keymap.set('n', '<leader>l', "<cmd>Leet<CR>")
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

require "flutter-tools".setup()
require "mini.pick".setup()
require "oil".setup({
	view_options = {
		show_hidden = true
	}
})
require "mason".setup()
require "nvim-autopairs".setup()
require "treesj".setup()
require "ibl".setup({
	indent = {
		char = '│'
	},
	scope = {
		enabled = true,
	}
})
-- require'nvim-treesitter'.install { "c", "cpp", "css", "javascript", "html", "lua", "typescript" }
-- require "nvim-treesitter.configs".setup({
-- 	highlight = { enable = true },
-- 	ensure_installed = { "c", "cpp", "css", "javascript", "html", "lua", "typescript" },
-- })
require "leetcode".setup({})
require "lspsaga".setup({})
require "blink.cmp".setup({

	completion = {
		list = {
			selection = {
				auto_insert = true,
				preselect = false,
			}
		}
	},

	keymap = {
		preset = "none",

		['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		['<C-e>'] = { 'hide' },

		['<CR>'] = { 'accept', 'fallback' },

		['<Up>'] = { 'select_prev', 'fallback' },
		['<Down>'] = { 'select_next', 'fallback' },

		['<Tab>'] = { 'select_next', 'fallback_to_mappings' },
		['<S-Tab>'] = { 'select_prev', 'fallback_to_mappings' },

		['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
		['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

		['<C-j>'] = { 'snippet_forward', 'fallback' },
		['<C-k>'] = { 'snippet_backward', 'fallback' },

		['<S-k>'] = { 'show_signature', 'hide_signature', 'fallback' },

	},
})

local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
	-- Rule for a pair with left-side ' ' and right side ' '
	Rule(' ', ' ')
	-- Pair will only occur if the conditional function returns true
			:with_pair(function(opts)
				-- We are checking if we are inserting a space in (), [], or {}
				local pair = opts.line:sub(opts.col - 1, opts.col)
				return vim.tbl_contains({
					brackets[1][1] .. brackets[1][2],
					brackets[2][1] .. brackets[2][2],
					brackets[3][1] .. brackets[3][2]
				}, pair)
			end)
			:with_move(cond.none())
			:with_cr(cond.none())
	-- We only want to delete the pair of spaces when the cursor is as such: ( | )
			:with_del(function(opts)
				local col = vim.api.nvim_win_get_cursor(0)[2]
				local context = opts.line:sub(col - 1, col + 2)
				return vim.tbl_contains({
					brackets[1][1] .. '  ' .. brackets[1][2],
					brackets[2][1] .. '  ' .. brackets[2][2],
					brackets[3][1] .. '  ' .. brackets[3][2]
				}, context)
			end)
}
-- For each pair of brackets we will add another rule
for _, bracket in pairs(brackets) do
	npairs.add_rules {
		-- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
		Rule(bracket[1] .. ' ', ' ' .. bracket[2])
				:with_pair(cond.none())
				:with_move(function(opts) return opts.char == bracket[2] end)
				:with_del(cond.none())
				:use_key(bracket[2])
		-- Removes the trailing whitespace that can occur without this
				:replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
	}
end
