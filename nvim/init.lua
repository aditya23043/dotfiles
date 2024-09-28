-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- PLUGINS
require("plugins")

-- lazy pkg manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = LAZY_PLUGIN_SPEC,
    change_detection = {
        enabled = false,
        notify = false,
    },
})


vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()

        if vim.g.colors_name == "dracula" and vim.o.background == "dark" then
            vim.api.nvim_set_hl(0, "Normal", { bg = "#16171d" })
            vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
            vim.api.nvim_set_hl(0, "LineNr", { fg = "#282a36" })
            vim.api.nvim_set_hl(0, "Comment", { fg = "#282a36" })
            vim.api.nvim_set_hl(0, "NonText", { fg = "#21232c" })
            vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#F8F8F2" })
            vim.api.nvim_set_hl(0, "StatusLine", { bg = "#16171d" })
        end

    end
})
