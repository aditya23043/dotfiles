local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Tab remap
keymap("n", "<C-i>", "<C-i>", opts)

keymap("n", "<C-f>", "<cmd>Oil<CR>", opts)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Register
keymap("x", "p", [["_dP]])

-- Line
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)

-- Wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", opts)

-- Buffer
keymap("n", "<M-j>", ":bnext<CR>", opts)
keymap("n", "<M-k>", ":bprevious<CR>", opts)

-- Horizontal Scrolling
keymap("n", "L", "10zl")
keymap("n", "H", "10zh")

-- Terminal
keymap("n", "<C-t>", ":split | terminal<CR>10<C-w>-i")
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

-- Reloading Config
keymap("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
keymap("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current line" })

-- Tab Navigation
keymap("n", "<C-.>", "gt")
keymap("n", "<C-,>", "gT")

-- Split size adjustment
keymap("n", "<M-a>", "<c-w>5<")
keymap("n", "<M-d>", "<c-w>5>")
keymap("n", "<M-w>", "<c-W>+")
keymap("n", "<M-s>", "<c-W>-")

keymap("n", "<esc>", "<cmd>nohl<CR>", opts)

-- Diagnostic
keymap("n", "[d", function() vim.diagnostic.jump({count=1, float=true}) end, { desc = "Go to previous [D]iagnostic message" })
keymap("n", "]d", function() vim.diagnostic.jump({count=-1, float=true}) end, { desc = "Go to next [D]iagnostic message" })
keymap("n", "<leader>d", function() vim.diagnostic.jump({count=1, float=true}) end, { desc = "Go to previous [D]iagnostic message" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>we", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

vim.cmd('abb Format lua vim.lsp.buf.format()')

keymap("n", "<leader>o", "<cmd>NvimTreeToggle<CR>")
