-- Formatters
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
    },
})

-- LSP
-- nvim-lspconfig ships lsp/pyright.lua with disableTaggedHints = true, which suppresses
-- the Unnecessary-tagged hints that dim unused variables/imports. Its rtp entry wins the
-- merge over our own lsp/pyright.lua, so override it here (vim.lsp.config takes priority).
vim.lsp.config('pyright', {
    settings = { pyright = { disableTaggedHints = false } },
})

vim.lsp.config('yamlls', {
    settings = {
        yaml = {
            customTags = {
                "!include scalar",
                "!include_text scalar",
                "!include_concat sequence",
                "!rel_path scalar",
            },
        },
    },
})

vim.lsp.enable({
    'pyright',
    'ts_ls',
    'hls',
    'lua_ls',
    'jsonls',
    'purescriptls',
    'yamlls',
})

if os.getenv("JAMIE_USES_RUST") == "TRUE" then
    vim.lsp.enable({ 'rust_analyzer' })
end
