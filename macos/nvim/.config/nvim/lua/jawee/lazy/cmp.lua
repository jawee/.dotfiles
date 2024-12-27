return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        local cmp = require("cmp")
        local source_mapping = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            path = "[Path]",
        }

        local select_opts = { behavior = cmp.SelectBehavior.Select }

        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = {
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
                ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
            },
            formatting = {
                fields = { 'abbr', 'kind', 'menu' },
                format = function(entry, vim_item)
                    local menu = source_mapping[entry.source.name]
                    vim_item.menu = menu
                    return vim_item
                end,
            },

            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
                { name = 'buffer' },
                { name = 'path' },
            })
        })

        cmp.setup.cmdline('/', {
            sources = {
                { name = 'buffer' }
            }
        })

        cmp.setup.cmdline(':', {
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })

    end
}
