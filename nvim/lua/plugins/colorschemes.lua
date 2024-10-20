local M = {
    -- { "dgox16/oldworld.nvim" },
    { "navarasu/onedark.nvim" },
    { "folke/tokyonight.nvim" },
    -- { "e-q/okcolors.nvim" },
    -- { "sainnhe/everforest" },
    { "sainnhe/gruvbox-material" },
    -- { "morhetz/gruvbox" },
    -- { "ishan9299/nvim-solarized-lua" },
    -- { "loctvl842/monokai-pro.nvim" },
    { "Mofiqul/vscode.nvim" },
    { "ellisonleao/gruvbox.nvim" },
    -- { "sam4llis/nvim-tundra" },
    -- { "akinsho/horizon.nvim" },
}

M.config = function()
    require("onedark").setup({
        style = "darker",
    })
    require("onedark").load()
end

return M
