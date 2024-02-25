local M = {
  "lukas-reineke/indent-blankline.nvim", 
  main = "ibl", 
  opts = {},
  config = function()
    require("ibl").setup{
      indent = {char = "┆"}
    }
  end
}

return M
