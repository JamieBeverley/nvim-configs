

return {
    -- multicursor
    {
        "mg979/vim-visual-multi",
        branch = "master",
    },
    -- Autocompletion and snippets
    {
        "hrsh7th/nvim-cmp",
        opts = function ()
            local cmp = require('cmp');
            local lsp_types = require("cmp.types").lsp
            return {
                sorting = {
                priority_weight = 2,
                comparators = {
                    -- Prioritize function parameters and variables
                    function(entry1, entry2)
                        local kind1 = entry1:get_kind()
                        local kind2 = entry2:get_kind()

                        local param_kinds = {
                            [lsp_types.CompletionItemKind.Variable] = true,
                            --[lsp_types.CompletionItemKind.Parameter] = true,
                        }

                        local is_param1 = param_kinds[kind1] or false
                        local is_param2 = param_kinds[kind2] or false

                        if is_param1 ~= is_param2 then
                            return is_param1
                        end
                    end,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

                    -- For `mini.snippets` users:
                        -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
                        -- insert({ body = args.body }) -- Insert at cursor
                        -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
                        -- require("cmp.config").set_onetime({ sources = {} })
                    end,
                },
                -- window = {
                    --     completion = cmp.config.window.bordered(),
                    --     -- documentation = cmp.config.window.bordered(),
                    -- },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    }),
                    sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        -- { name = 'vsnip' }, -- For vsnip users.
                        -- { name = 'luasnip' }, -- For luasnip users.
                        -- { name = 'ultisnips' }, -- For ultisnips users.
                        -- { name = 'snippy' }, -- For snippy users.
                    }, {
                        { name = 'buffer' },
                    })

                }
            end
        },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        -- { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/vim-vsnip' },
        { "psf/black", branch="stable" },
        {
            "akinsho/toggleterm.nvim",
            version = "*",
            config = true,
            opts = {
                direction = "horizontal",
                size = 20,
                open_mapping = [[<C-\>]],
                start_in_insert = true,
                terminal_mappings = true,
                persist_mode = true,
                persist_size = true,
            },
        },
        {
            "klen/nvim-config-local",
            opts = {
                config_files = { ".nvim.lua"}
            }
        },
        {
            "nvimtools/none-ls.nvim", 
            dependencies = { "nvim-lua/plenary.nvim" 
        },
        { "neovim/nvim-lspconfig" }, 
        { "folke/which-key.nvim" },
        { "sharkdp/fd" },
        {
            "nvim-treesitter/nvim-treesitter",
            build = function()
                require("nvim-treesitter.install").update({ with_sync = true})()
            end,
            opts = {
                ensure_installed = { "javascript", "python", "typescript", "html", "css", "lua" },
                highlight = { enable = true },
                indent = { enable = true },
            }
        },
        { 
            "nvim-telescope/telescope.nvim",
            tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter', 'sharkdp/fd' }
        },
        { "nvim-tree/nvim-web-devicons", opts = {}},
        {
            "nvim-tree/nvim-tree.lua",
            lazy = false,
            config = function()
                require("nvim-tree").setup{
                    -- renderer = { icons = { show = { file = false, folder = false } } },
                    git = { ignore = false }
                }
                vim.api.nvim_create_autocmd({ "VimEnter" }, {
                    callback = function()
                        require("nvim-tree.api").tree.open()
                    end
                })
            end,
        },
        { 
            "danymat/neogen", 
            config = true,
        }
    },
    -- copilot...
    {
        "github/copilot.vim"
    }
}
