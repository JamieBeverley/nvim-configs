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
        -- TODO this isn't quite right...
        -- quick fix is just to make pyrightconfig.json lives
        -- in cwd, eg: {"venvPath": ".", "venv": ".venv"}
        local root = root_pattern(vim.fn.getcwd())
        if not root then
            return {}
        end

        local pyright_config = root and root .. '/pyrightconfig.json'
        local has_pyright_config = pyright_config and vim.fn.filereadable(pyright_config) == 1
        if has_pyright_config then
            print("using", pyright_config)
            return {} -- Don't override; let pyrightconfig.json handle it
        else
            -- if root/.venv exists then use it, otherwise leave unconfigured
            local venv = root .. '.venv'
            local has_venv = venv and vim.fn.isdirectory(venv) == 1
            if has_venv then
                print("found venv at ", venv," - using that")
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

lspconfig.ts_ls.setup {}
lspconfig.hls.setup {
    filetypes = { 'haskell', 'lhaskell', 'cabal' }
}

lspconfig.lua_ls.setup {}

lspconfig.jsonls.setup {
    init_options = {
        provideFormatter = true
    },
    commands = {
      Format = {
        function()
            vim.lsp.buf.format({timeout_ms=5000})
            -- vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}
