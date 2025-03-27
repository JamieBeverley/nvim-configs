local lspconfig = require('lspconfig')
lspconfig.basedpyright.setup {
    settings = {
        basedpyright = {
    
        }
    }
}

lspconfig.ts_ls.setup{
}
lspconfig.hls.setup{
      filetypes = { 'haskell', 'lhaskell', 'cabal' }
}

