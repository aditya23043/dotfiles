local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
  config = function()
    local highlight = {
      "iblHighlighted"
    }
    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "iblHighlighted", { fg = "#282828" })
    end)
    require("ibl").setup {
      indent = { char = "│",
        highlight = highlight }
    }
  end
}

return M
