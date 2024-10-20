-- local border = { "┏",  "━",  "┓",  "┃",  "┛",  "━",  "┗",  "┃", }
-- local border = { "╔",  "═",  "╗",  "║",  "╝",  "═",  "╚",  "║", }
-- local border2 = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
-- local border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
-- local border1 = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }

local M = {
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
}

function M.config()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    -- require("luasnip/loaders/from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load()
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
            -- ["<C-h>"] = cmp.mapping(function()
                -- 	if luasnip.locally_jumpable(-1) then
                -- 		luasnip.jump(-1)
                -- 	end
                -- end, { "i", "s" }),
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
                    -- border = border1,
                    scrollbar = true,
                },
                documentation = {
                    -- border = border1,
                    scrollbar = true,
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

    return M
