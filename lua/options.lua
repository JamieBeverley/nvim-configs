vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.termguicolors = true
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')


-- advised for nvim-tree
vim.g.loaded_netrw = 1

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.lsp.buf.format()
    end,
})

