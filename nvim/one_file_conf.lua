vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NOTE: OPTIONS {{{

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Make line numbers default
vim.opt.number = true

-- set relative numbered lines
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Show fold lines in column
-- vim.cmd("set foldcolumn=1")

-- always show tabs
vim.opt.showtabline = 0

-- convert tabs to spaces
vim.opt.expandtab = true

-- the number of spaces inserted for each indentation
vim.opt.shiftwidth = 2

-- insert 4 spaces for a tab
vim.opt.tabstop = 2

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Show last executed comand
vim.opt.showcmd = false

vim.opt.ruler = false

-- Enable break indent
vim.opt.breakindent = true

-- make indenting smarter again
vim.opt.smartindent = true

-- Save undo history
vim.opt.undofile = false

-- more space in the neovim command line for displaying messages
vim.opt.cmdheight = 1

-- mostly just for cmp
vim.opt.completeopt = { "menuone", "noselect" }

-- pop up menu height
vim.opt.pumheight = 10
vim.opt.pumblend = 0

-- so that `` is visible in markdown files
vim.opt.conceallevel = 3

-- Status bar
vim.opt.laststatus = 2

-- the encoding written to a file
vim.opt.fileencoding = "utf-8"

-- creates a backup file
vim.opt.backup = false

-- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.writebackup = false

-- creates a swapfile
vim.opt.swapfile = false

-- set term gui colors (most terminals support this)
vim.opt.termguicolors = true

-- display lines as one long line
vim.opt.wrap = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 100

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 100

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.-- Sets how neovim will display certain whitespace characters in the editor. -- Sets how neovim will display certain whitespace characters in the editor.

vim.opt.list = true
-- vim.opt.listchars = "tab:»,trail:·,nbsp:␣"
vim.opt.listchars = { trail = "", eol = "󱞦", nbsp = "␣", lead = "", extends = "", precedes = "", tab = "  " }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Don't have `o` add a comment
vim.opt.formatoptions:remove("o")

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

vim.opt.title = false
vim.opt.spell = false

-- Correct the wrong indentation of clangd LSP
vim.opt.cindent = true

-- NETRW
vim.g.netrw_banner = 1
vim.g.netrw_mouse = 2

-- }}}
-- NOTE: KEYMAPS {{{

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

-- }}}
-- NOTE: LAZY {{{

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

 -- colorscheme {{{2
  {
    "dracula/vim",
    name = "dracula",
    config = function ()
       vim.cmd.colorscheme "dracula"
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
  }, -- }}}

  -- Auto detect tabstop and shiftwidth {{{2
	"tpope/vim-sleuth",
  -- }}}

	-- Formatting {{{2
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = false, cpp = false }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
  --- }}}

	-- Commenting using gcc {{{2
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
  -- }}}

  -- LSP {{{2
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
        rust_analyzer = {},
        bashls = {},
        -- asm_ls = {},
        denols = {},
        -- pyright = {},
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
          filetypes = { "c", "cpp", "java" },
        },

        -- htmx = {},

        -- ltex = {},
        jdtls = {},
        ast_grep = {
          default_config = {
            single_file_support = true,
          },
          filetypes = { "java" }
        },
        gopls = {},
        biome = {
          default_config = {
            single_file_support = true,
          }
        },
        emmet_ls = {},
        html = {},
        cssls = {},
        pylsp = {},
        pyright = {},
        verible = {},
      }

      local default_diagnostic_config = {
        signs = {
          text = {
            -- [vim.diagnostic.severity.ERROR] = '',
            -- [vim.diagnostic.severity.WARN] = '',
            -- [vim.diagnostic.severity.INFO] = '',
            -- [vim.diagnostic.severity.HINT] = ''
            -- [vim.diagnostic.severity.ERROR] = '',
            -- [vim.diagnostic.severity.WARN] = '',
            -- [vim.diagnostic.severity.INFO] = '',
            -- [vim.diagnostic.severity.HINT] = ''
            [vim.diagnostic.severity.ERROR] = '>>',
            [vim.diagnostic.severity.WARN] = '>>',
            [vim.diagnostic.severity.INFO] = '>>',
            [vim.diagnostic.severity.HINT] = '>>'
          }
        },

        virtual_text = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        open_float = {
          enable = true,
        },
        float = {
          enable = true,
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
          javascript = { "biome" },
          c = { "clang-format" },
          markdown = { "prettier" },
          haskell = { "fourmolu" },
          rust = { "rustfmt" },
          go = { "crlfmt" },
          verilog = { "verible" },
          html = { "htmlbeautifier" },
          css = { "prettier" },
          -- asm = { "asmfmt" },
        },
      })

    end,
  },
  -- }}}

  -- Completion {{{2
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
            -- elseif luasnip.expand_or_locally_jumpable() then
            -- 	luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            -- elseif luasnip.locally_jumpable(-1) then
            -- 	luasnip.jump(-1)
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
    end
  }
  -- }}}

})

-- }}}
-- vim: ts=2 sts=2 sw=2 foldmethod=marker et
