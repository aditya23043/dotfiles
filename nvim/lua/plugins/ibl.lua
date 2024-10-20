local M = {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
        local highlight = { "iblHighlighted" }
        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "iblHighlighted", { fg = "#484848" })
            vim.api.nvim_set_hl(0, "_iblscope", { fg = "#ebdbb2" })
        end)
        require("ibl").setup {
            indent = {
                highlight = highlight,
                char = '│'
            },
            scope = {
                enabled = true,
                highlight = "_iblscope"
            }
        }
    end
}

return M
