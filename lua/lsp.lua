
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
lspconfig.basedpyright.setup {
      settings = {
         basedpyright = {
 
         }
     }
}
-- jinja
local configs = require('lspconfig.configs')

vim.filetype.add({extension={
    jinja='jinja',
    j2='jinja',
    ["py.j2"]='jinja',
    jinja2='jinja'
}})
lspconfig.jinja_lsp.setup{
    name = "jinja-lsp",
    cmd = { 'jinja-lsp' },
    filetypes = { 'jinja' },
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = { jinja = { } },
}
-- configs.jinja_lsp = {
--     default_config = {
--         name = "jinja-lsp",
--         cmd = { 'jinja-lsp' },
--         filetypes = { 'jinja' },
--         -- root_dir = function(fname)
--             --   return "."
--             --   --return nvim_lsp.util.find_git_ancestor(fname)
--             -- end,
--             -- init_options = {
--                 --   templates = './templates',
--                 --   backend = { './src' },
--                 --   lang = "rust"
--                 -- },
--     },
-- }
-- ts
lspconfig.ts_ls.setup{}
-- hs
lspconfig.hls.setup{
    filetypes = { 'haskell', 'lhaskell', 'cabal' }
}

