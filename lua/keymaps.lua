local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })

function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    -- esc key to enter normal mode
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    -- ctrl + W to enter window mode (skip the ctrl \ + ctrl n)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-W>]], { noremap=true, silent=true })
    -- go to insert mode by default
    vim.api.nvim_input('i')
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- auto-set to insert mode when switching to a terminal buffer
-- for some reason TermEnter doesn't seem to work
vim.cmd("autocmd BufWinEnter,WinEnter term://* startinsert")


