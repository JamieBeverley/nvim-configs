return {
    init_options = { provideFormatter = true },
    commands = {
        Format = {
            function()
                vim.lsp.buf.format({ timeout_ms = 5000 })
            end,
        },
    },
}
