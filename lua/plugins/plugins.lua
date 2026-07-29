local claude = {
    "greggh/claude-code.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
        -- Only these environment variables are passed through to the Claude CLI.
        -- `env -i` starts from an empty environment; each approved var is re-added
        -- from the current shell env. Edit this list to allow/deny vars.
        local allowed_env = {
            "COLORTERM",
            "HOME", -- config + credentials location
            "LANG",
            "PATH", -- needed to find node / claude / git
            "SHELL",
            "SSL_CERT_FILE",
            "TERM", -- terminal type for rendering
            "USER",
        }
        local env_assignments = {}
        for _, name in ipairs(allowed_env) do
            table.insert(env_assignments, string.format('%s="$%s"', name, name))
        end
        -- Name each session after the project (git root name, or cwd name outside git repos)
        local claude_cmd = 'claude --name "$(basename $(git rev-parse --show-toplevel 2>/dev/null || pwd))"'
        local command = string.format("env -i %s bash -c '%s'",
            table.concat(env_assignments, " "), claude_cmd)

        require("claude-code").setup(
            {
                command = command,
                command_variants = {
                    continue = "--continue",
                    resume = "--resume",
                    verbose = "--verbose",
                },
                window = {
                    position = "vertical",       -- Position of the window: "botright", "topleft", "vertical", "float", etc.
                    enter_insert = false,        -- Don't auto-enter insert mode when switching to Claude buffer
                    start_in_normal_mode = true, -- Prevent force_insert_mode autocmd from overriding enter_insert
                },
                keymaps = {
                    toggle = {
                        normal = "<C-\\>",           -- Normal mode keymap for toggling Claude Code, false to disable
                        terminal = "<C-\\>",         -- Terminal mode keymap for toggling Claude Code, false to disable
                        variants = {
                            continue = "<leader>cC", -- Continue most recent session
                            resume = "<leader>cR",   -- Interactive session picker
                            verbose = "<leader>cV",
                        },
                    },
                    window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
                    scrolling = true,         -- Enable scrolling keymaps (<C-f/b>) for page up/down
                }
            }
        )
    end
}

local resize = {
    "jamiebeverley/resize-mode.nvim",
    tag = "v1.0.0",
    config = function()
        require("resize-mode").setup()
    end,
}


return {
    -- open_code,
    claude,
    resize,
    {
        'davidgranstrom/scnvim',
        ft = 'supercollider',
        config = function()
            local scnvim = require 'scnvim'
            local map = scnvim.map
            local map_expr = scnvim.map_expr

            scnvim.setup({
                keymaps = {
                    ['<M-e>'] = map('editor.send_line', { 'i', 'n' }),
                    ['<C-s>'] = {
                        map('editor.send_block', { 'i', 'n' }),
                        map('editor.send_selection', 'x'),
                    },
                    ['<CR>'] = map('postwin.toggle'),
                    ['<M-CR>'] = map('postwin.toggle', 'i'),
                    ['<M-L>'] = map('postwin.clear', { 'n', 'i' }),
                    ['<C-k>'] = map('signature.show', { 'n', 'i' }),
                    ['<F12>'] = map('sclang.hard_stop', { 'n', 'x', 'i' }),
                    ['<leader>st'] = map('sclang.start'),
                    ['<leader>sk'] = map('sclang.recompile'),
                    ['<F1>'] = map_expr('s.boot'),
                    ['<F2>'] = map_expr('s.meter'),
                },
                editor = {
                    highlight = {
                        color = 'IncSearch',
                    },
                },
                -- postwin = {
                --   float = {
                --     enabled = true,
                --   },
                -- },
            })
        end
    },
    {
        'akinsho/bufferline.nvim',
        version = "v4.9.1",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    indicator = { style = "underline" }, -- options: 'icon', 'underline', 'none'
                    mode = "buffers",                    -- show buffers (not tabs)
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    separator_style = "thin",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "Files",
                            highlight = "NvimTreeNormal",
                            separator = false,
                        },
                    },
                },
            })
        end
    },
    {
        "jamiebeverley/nvim-tidal",
        -- dir = "/home/jamie/repos/experiments/nvim-tidal",
        name = "nvim-tidal",
        lazy = false,
        config = function()
            return require("nvim-tidal").setup({
                boot_tidal = "~/BootTidal.hs"
            })
        end
    },
    -- {
    --     "ravitemer/mcphub.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --     },
    --     build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
    --     config = function()
    --         local config_file_name = "/mcp-servers.json"
    --         local mcp_servers_json = vim.fn.getcwd() .. config_file_name
    --         -- if the file doesn't exist default to ~/.config/nvim/mcp-servers.json
    --         if not vim.loop.fs_stat(mcp_servers_json) then
    --             mcp_servers_json = vim.fn.stdpath("config") .. config_file_name
    --         end
    --
    --         require("mcphub").setup({
    --             config = mcp_servers_json,
    --             log = {
    --                 level = vim.log.levels.DEBUG,
    --             }
    --         })
    --     end
    -- },
    -- multicursor
    {
        "mg979/vim-visual-multi",
        branch = "master",
    },
    -- Autocompletion and snippets
    {
        "hrsh7th/nvim-cmp",
        opts = function()
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
    { "psf/black",           branch = "stable" },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true,
        opts = {
            direction = "horizontal",
            size = 20,
            open_mapping = [[<C-_>]],
            start_in_insert = true,
            terminal_mappings = true,
            persist_mode = true,
            persist_size = true,
        },
    },
    {
        "klen/nvim-config-local",
        opts = {
            config_files = { ".nvim.lua" }
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
            -- the `main` branch is the rewrite; `master` does not support nvim 0.12
            "nvim-treesitter/nvim-treesitter",
            branch = "main",
            lazy = false,
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter").install({
                    "javascript", "python", "typescript", "html", "css", "lua",
                    "markdown", "markdown_inline",
                })
                -- `main` no longer enables highlight/indent for you
                vim.api.nvim_create_autocmd("FileType", {
                    callback = function(args)
                        if not pcall(vim.treesitter.start, args.buf) then
                            return
                        end
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end,
                })
            end,
        },
        {
            "nvim-telescope/telescope.nvim",
            tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter', 'sharkdp/fd' }
        },
        { "nvim-tree/nvim-web-devicons", opts = {} },
        {
            "nvim-tree/nvim-tree.lua",
            lazy = false,
            config = function()
                require("nvim-tree").setup {
                    -- renderer = { icons = { show = { file = false, folder = false } } },
                    git = { ignore = false }
                }
                -- auto-open NvimTree when nvim is opened
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
    { "b0o/schemastore.nvim" },
    -- copilot...
    -- {
    --     "github/copilot.vim"
    -- }
}
