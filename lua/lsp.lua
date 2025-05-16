
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
-- lspconfig.basedpyright.setup {
--       settings = {
--          basedpyright = {
--  
--          }
--      }
-- }
lspconfig.pyright.setup {
    settings = {
        pyright = {}
    }
}

lspconfig.ts_ls.setup{}
lspconfig.hls.setup{
    filetypes = { 'haskell', 'lhaskell', 'cabal' }
}

