-- Formatters
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
    },
})

-- LSP
vim.lsp.enable({
    'pyright',
    'ts_ls',
    'hls',
    'lua_ls',
    'jsonls',
    'purescriptls',
})

if os.getenv("JAMIE_USES_RUST") == "TRUE" then
    vim.lsp.enable({ 'rust_analyzer' })
end
