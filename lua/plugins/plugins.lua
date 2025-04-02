

return {
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
    { "nvimtools/none-ls.nvim", 
      dependencies = { "nvim-lua/plenary.nvim" }
    },
    { "neovim/nvim-lspconfig" }, 
    { "folke/which-key.nvim" },
    { "sharkdp/fd" },
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_syinc = true})()
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
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        config = function()
            require("nvim-tree").setup{
                renderer = { icons = { show = { file = false, folder = false } } }
            }
            vim.api.nvim_create_autocmd({ "VimEnter" }, {
                callback = function()
                    require("nvim-tree.api").tree.open()
                end
            })
        end,
    }
}
