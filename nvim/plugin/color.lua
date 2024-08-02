vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Onedark
    if vim.g.colors_name == "onedark" then
      -- vim.api.nvim_set_hl(0, "Comment", { fg = "#373c49", italic = true })
      vim.api.nvim_set_hl(0, "Comment", { fg = "#2c313a", italic = true })
      vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
      -- vim.api.nvim_set_hl(0, "StatusLine", { fg = "#7c879c", bg = "#1d2026" })
      vim.api.nvim_set_hl(0, "StatusLine", { fg = "#7c879c", bg = "none" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#2c313a" })
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "#16181d" })
      vim.api.nvim_set_hl(0, "Normal", { bg = "#21252b", fg = "#abb2bf" })
      -- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#282c34" })
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#1f2329" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "#1f2329" })
      vim.api.nvim_set_hl(0, "CurSearch", { bg = "#e06c75", fg = "#000000" })
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "Search", { fg = "#e06c75" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#1f2329", fg = "#1f2329" })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1f2329" })
      vim.api.nvim_set_hl(0, "MatchParen", { underline = true, fg = "#e06c75", })

      -- Default edit
    elseif vim.g.colors_name == "default" then
      vim.api.nvim_set_hl(0, "Comment", { fg = "#333333" })
      vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#333333" })
      vim.api.nvim_set_hl(0, "CurSearch", { bg = "#e06c75", fg = "#000000" })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#18141c" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#26202d" })
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "Search", { fg = "#e06c75", bg = "#000000" })
      vim.api.nvim_set_hl(0, "WildMenu", { fg = "#000000", bg = "#abb2bf" })
      vim.api.nvim_set_hl(0, "Pmenu", { fg = "#abb2bf", bg = "#000000" })
      vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#000000", bg = "#abb2bf" })
      vim.api.nvim_set_hl(0, "StatusLine", { fg = "#000000", bg = "#abb2bf" })

      -- Ok colors
    elseif vim.g.colors_name == "okcolors" then
      vim.api.nvim_set_hl(0, "Comment", { fg = "#222222" })
      vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#26202d" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#222222" })
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "Search", { fg = "#e06c75" })
      vim.api.nvim_set_hl(0, "WildMenu", { fg = "#000000", bg = "#abb2bf" })
      vim.api.nvim_set_hl(0, "Pmenu", { fg = "#abb2bf", bg = "#000000" })
      vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#000000", bg = "#abb2bf" })

      -- Tokyonight
    elseif vim.g.colors_name == "tokyonight" then
      vim.api.nvim_set_hl(0, "Comment", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })

      -- Gruvbox
    elseif vim.g.colors_name == "gruvbox-material" then
      vim.api.nvim_set_hl(0, "Normal", { bg = "#141617" })
      vim.api.nvim_set_hl(0, "Comment", { fg = "#242729" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#242729" })
      vim.api.nvim_set_hl(0, "Statusline", { fg = "#ddc7a1", bg = "none" })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#181a1b" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828" })
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "#282828" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#242729" })
    end
  end,
})

vim.cmd.colorscheme("gruvbox-material")
