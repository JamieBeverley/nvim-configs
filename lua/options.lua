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

-- all yank/delete/put commands to use clipboard
vim.cmd('set clipboard=unnamedplus')

-- auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.lsp.buf.format()
    end,
})

