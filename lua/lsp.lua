
-- Formatters
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
    },
})

-- LSP
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local root_pattern = util.root_pattern('pyrightconfig.json', 'pyproject.toml', '.git')

lspconfig.pyright.setup({
    root_dir = root_pattern,
    settings = (function()
        local root = root_pattern(vim.fn.getcwd())
        if not root then
            return {}
        end

        local pyright_config = root and root .. '/pyrightconfig.json'
        local has_pyright_config = pyright_config and vim.fn.filereadable(pyright_config) == 1
        if has_pyright_config then
            return {} -- Don't override; let pyrightconfig.json handle it
        else
            -- if root/.venv exists then use it, otherwise leave unconfigured
            local venv = root .. '.venv'
            local has_venv = venv and vim.fn.isdirectory(venv) == 1
            if has_venv then
                return {
                    python = {
                        venvPath = root,
                        venv = root .. '.venv'
                    }
                }
            end
            return {
            }
        end
    end)()
})

lspconfig.ts_ls.setup{}
lspconfig.hls.setup{
    filetypes = { 'haskell', 'lhaskell', 'cabal' }
}

