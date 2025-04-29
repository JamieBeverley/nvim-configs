local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<C-P>', telescope_builtin.find_files, { noremap = true, silent = false })
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<C-G>', telescope_builtin.live_grep, { noremap = true, silent = false })


-- rename
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, silent = false })

-- Show lsp error info
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic at cursor" })

function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts) vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts) vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    -- go to insert mode by default
    -- vim.api.nvim_input('i')
    -- ctrl + W to enter window mode (skip the ctrl \ + ctrl n)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-W>]], { noremap=true, silent=true })
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Hack so terminal renders 'right' of tree... probably doesn't belong here...
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        local Terminal  = require('toggleterm.terminal').Terminal
        local terminal = Terminal:new()
    end
})

-- Black formatter
--vim.api.nvim_set_keymappp('n', '<Leader>fmt', ':!black %<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>fmt', function()
    vim.lsp.buf.format(
    {
        async = false,
        filter = function(client) return client.name == "null-ls" end,
    })
end, { noremap = true, silent = false })

-- remapped from <C-L> so that can us <C-h/j/k/l> to move windows without going into window mode...
-- vim.keymap.set('n', '<C-R>', '<Cmd>nohlsearch|diffupdate|normal! <C-L><CR>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 'n' }, '<C-H>', [[<C-W><C-H>]], { noremap = true, silent = true })
vim.keymap.set({ 'i', 'n' }, '<C-J>', [[<C-W><C-J>]], { noremap = true, silent = true })
vim.keymap.set({ 'i', 'n' }, '<C-K>', [[<C-W><C-K>]], { noremap = true, silent = true })
vim.keymap.set({ 'i', 'n' }, '<C-L>', [[<C-W><C-L>]], { noremap = true, silent = true })
-- Disabled for now -> possibly use in place of toggleterm
-- function _G.set_terminal_keymaps()
--     local opts = {buffer = 0}
--     -- esc key to enter normal mode
--     vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
--     -- ctrl + W to enter window mode (skip the ctrl \ + ctrl n)
--     vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-W>]], { noremap=true, silent=true })
--     -- go to insert mode by default
--     vim.api.nvim_input('i')
-- end
-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- 
-- -- auto-set to insert mode when switching to a terminal buffer
-- -- for some reason TermEnter doesn't seem to work
-- vim.cmd("autocmd BufWinEnter,WinEnter term://* startinsert")
-- 
-- local last_non_terminal_buf = nil
-- local last_terminal_buf = nil
-- vim.api.nvim_create_autocmd("BufEnter", {
--     callback = function()
--         local buftype = vim.bo.buftype
--         if buftype ~= "terminal" then
--             last_non_terminal_buf = vim.fn.bufnr()
--             print("terminal buf set to " .. vim.fn.bufnr()) else last_terminal_buf = vim.fn.bufnr() print("non-term buf set to " .. vim.fn.bufnr()) end end, }) function SwitchToLastNonTerminalBuffer()
--     print("switch to buffer: " .. last_non_terminal_buf)
--     if last_non_terminal_buf then
--         vim.cmd("buffer " .. last_non_terminal_buf)
--     end
-- end
-- function SwitchToLastTerminal()
--     print("switch to term: " .. last_terminal_buf)
--     if last_terminal_buf then
--         vim.cmd("buffer " .. last_terminal_buf)
--     end
-- end
-- 
-- 
-- vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<C-B>', SwitchToLastNonTerminalBuffer, { noremap = true, silent = false })
-- vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<C-T>', SwitchToLastTerminal, { noremap = true, silent = false })
-- 
