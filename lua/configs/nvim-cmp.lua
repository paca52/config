local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 25
local MAX_LABEL_HEIGHT = 25

local get_ws = function (max, len)
    return (" "):rep(max - len)
end

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                { "hrsh7th/cmp-nvim-lsp-signature-help" },
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
            },
        },
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
    },
    config = function()
        local compare = require('cmp.config.compare')
        local kind_icons = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
        }
        -- See `:help cmp`
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        luasnip.config.setup({})

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = "menu,menuone,noinsert" },

            mapping = cmp.mapping.preset.insert({
                -- Select the [n]ext item
                ["<Tab>"] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window [b]ack / [f]orward
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ["<CR>"] = cmp.mapping.confirm({ select = true }),

                -- Manually trigger a completion from nvim-cmp.
                ["<C-Space>"] = cmp.mapping.complete({}),

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end
                --
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

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            }),

            sources = {
                { name = "nvim_lsp", priority = 8 },
                { name = "luasnip", priority = 7 },
                { name = "path" },
                { name = 'nvim_lsp_signature_help' },
            },

            sorting = {
                priority_weight = 1.0,
                comparators = {
                    compare.locality,
                    compare.recently_used,
                    compare.score
                }
            },

            performance = {
                max_view_entries = 50,
                debounce = 60,
                throttle = 30,
                fetching_timeout = 500,
                confirm_resolve_timeout = 80,
                async_budget = 1,
            },

            matching = {
                disallow_symbol_nonprefix_matching = true,
                disallow_fuzzy_matching = true,
                disallow_fullfuzzy_matching = true,
                disallow_partial_fuzzy_matching = true,
                disallow_partial_matching = false,
                disallow_prefix_unmatching = true,
            },

            min_length = 0,

            formatting = {
                expandable_indicator = true,
                fields = { "abbr", "kind", "menu" },
                format = function(entry, vim_item)
                    local kind = vim_item.kind
                    vim_item.kind = " " .. (kind_icons[kind] or "?") .. ""

                    local content = vim_item.abbr

                    if #content > MAX_LABEL_WIDTH then
                        vim_item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
                    else
                        vim_item.abbr = content .. get_ws(MAX_LABEL_WIDTH, #content)
                    end


                    -- local source = entry.source.name
                    -- vim_item.menu = "[" .. source .. "]"
                    -- vim_item.menu = "[" .. kind .. "]"
                    vim_item.menu = kind

                    return vim_item
                end
            },

        })
    end,
}
