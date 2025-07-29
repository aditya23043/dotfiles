require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.signcolumn = "yes"

vim.cmd.colorscheme "retrobox"

vim.keymap.set('n', '<leader>w', 'V$%zf')
vim.keymap.set('n', '<esc><esc>', '<cmd>nohl<CR>')
vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>')
vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>t', '<cmd>Lspsaga term_toggle<CR>')
vim.keymap.set('n', '<leader><leader>', '<cmd>Lspsaga code_action<CR>', { noremap = true })
vim.keymap.set('n', '<leader>d', function()
	local date = vim.fn.system('date "+%B %d %Y"')
	date = vim.trim(date)
	date = "* " .. date
	vim.api.nvim_put({ date }, "l", true, false)
end)

vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
