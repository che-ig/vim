local cmp = require 'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'lsp',
                luasnip = 'snip',
                buffer = 'file',
                path = 'path'
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, {"i", "s"})
    }),
    sources = cmp.config.sources({
        -- https://github.com/VonHeikemen/lsp-zero.nvim/discussions/361
        {name = "path"}, {name = "nvim_lsp", keyword_length = 3},
        {name = "buffer", keyword_length = 1},
        {name = "luasnip", keyword_length = 2},
        {name = "nvim_lsp_signature_help"}

    })
})
-- TODO вернуться к данному конфигу
-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--     sources = cmp.config.sources({
--         {name = 'cmp_git'} -- You can specify the `cmp_git` source if you were installed it.
--     }, {{name = 'buffer'}})
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- т.е в режиме поиска (/) у нас по мере набора текста будет появляться плашка с результатами поиска
cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})
