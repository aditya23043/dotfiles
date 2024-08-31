-- NOTE: PLUGIN INIT
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: PLUGINS
require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {},
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
  },
  {
    "tpope/vim-markdown",
    config = function()
      vim.g.markdown_folding = 1
      vim.g.markdown_fenced_languages = { "asm", "cpp", "python", "java", "lua" }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp",
        event = "InsertEnter",
      },
      {
        "hrsh7th/cmp-buffer",
        event = "InsertEnter",
      },
      {
        "hrsh7th/cmp-path",
        event = "InsertEnter",
      },
      {
        "hrsh7th/cmp-cmdline",
        event = "InsertEnter",
      },
      {
        "saadparwaiz1/cmp_luasnip",
        event = "InsertEnter",
      },
      {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
      },
      {
        "hrsh7th/cmp-nvim-lua",
      },
    },
    config = function()
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
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
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
            -- border = border,
            -- scrollbar = "║",
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
        bashls = {},
        pyright = {},
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
          filetypes = { "c", "cpp" },
        },
        -- ltex = {},
        jdtls = {},
        -- hls = {},
        ast_grep = {
          default_config = {
            single_file_support = true,
          },
        },
      }

      local default_diagnostic_config = {
        signs = {
          text = {
            -- [vim.diagnostic.severity.ERROR] = '',
            -- [vim.diagnostic.severity.WARN] = '',
            -- [vim.diagnostic.severity.INFO] = '',
            -- [vim.diagnostic.severity.HINT] = ''
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },

        virtual_text = false,
        update_in_insert = false,
        underline = false,
        severity_sort = true,
        float = {
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
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0 })
          vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = 0 })

          vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })

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
          c = { "clang-format", "ast-grep" },
          markdown = { "prettier" },
          haskell = { "fourmolu" },
        },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          require("conform").format({
            bufnr = args.buf,
            lsp_fallback = true,
            quiet = true,
          })
        end,
      })
    end,
  },
})

-- NOTE: OPTIONS

vim.cmd.colorscheme("gruvbox-material")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.mouse = "a"
vim.opt.numberwidth = 2
vim.opt.relativenumber = false
vim.opt.showmode = false
vim.opt.showtabline = 1
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.undofile = false
vim.opt.cmdheight = 1
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.pumheight = 10
vim.opt.pumblend = 0
vim.opt.conceallevel = 3
vim.opt.laststatus = 3
vim.opt.fileencoding = "utf-8"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 500
vim.opt.timeoutlen = 500
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.formatoptions:remove("o")
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.title = false
vim.opt.spell = false
vim.opt.cindent = true
vim.g.netrw_banner = 1
vim.g.netrw_mouse = 2

-- if vim.g.colors_name == "tokyonight" then
-- 	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 	vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
-- 	vim.api.nvim_set_hl(0, "LineNr", { bg = "none", fg = "#242729" })
-- 	vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", fg = "#1abc9c" })
-- 	-- vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", fg = "#7dcfff" })
-- 	vim.api.nvim_set_hl(0, "Comment", { fg = "#2f3437", italic = true })
-- 	vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
-- 	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- 	vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
-- end
if vim.g.colors_name == "gruvbox-material" then
  vim.api.nvim_set_hl(0, "Comment", { fg = "#383838" })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#383838" })
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
end

-- NOTE: Keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Tab remap
keymap("n", "<C-i>", "<C-i>", opts)

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

-- Move right easily in insert mode
keymap("i", "<C-l>", "<right>", opts)

-- Buffer
keymap("n", "<M-j>", ":bnext<CR>", opts)
keymap("n", "<M-k>", ":bprevious<CR>", opts)

-- Horizontal Scrolling
keymap("n", "L", "10zl")
keymap("n", "H", "10zh")

-- Terminal
keymap("n", "<C-t>", ":split | terminal<CR>10<C-w>-i")
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

-- Open a terminal at the bottom of the screen with a fixed height.
keymap("n", "<leader>t", function()
  vim.cmd.new()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)
  vim.wo.winfixheight = true
  vim.cmd.term()
end)

-- Reloading Config
-- keymap("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
-- keymap("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current line" })

-- Tab Navigation
keymap("n", "<C-.>", "gt")
keymap("n", "<C-,>", "gT")

-- Split size adjustment
keymap("n", "<M-,>", "<c-w>5<")
keymap("n", "<M-.>", "<c-w>5>")
keymap("n", "<M-t>", "<c-W>+")
keymap("n", "<M-s>", "<c-W>-")

keymap("n", "<esc>", "<cmd>nohl<CR>", opts)

-- Toggle hlsearch if it's on, otherwise just do "enter"
keymap("n", "<CR>", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.hlsearch:get() then
    vim.cmd.nohl()
    return ""
  else
    return "<CR>"
  end
end, { expr = true })

-- Diagnostic
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>we", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
