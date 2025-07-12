local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set({ 'n', 'i', 'v', 'x', 't' }, '<C-P>', telescope_builtin.find_files, { noremap = true, silent = false })
vim.keymap.set({ 'n', 'i', 'v', 'x', 't' }, '<C-G>', telescope_builtin.live_grep, { noremap = true, silent = false })


-- code companion chat
vim.keymap.set('n', '<leader>ccc', function()
    vim.fn.feedkeys(':CodeCompanionChat toggle\n', 'n')
end, { noremap = true, silent = true, desc = "CodeCompanionChat toggle" })

vim.keymap.set('n', '<leader>cca', function()
    vim.fn.feedkeys(':CodeCompanionActions \n', 'n')
end, { noremap = true, silent = true, desc = "CodeCompanionActions" })




-- Visual selection utils
vim.keymap.set('v', '<leader>slw', function()
        vim.fn.feedkeys(':s/\\s*\\(.*\\)/\\1/g', 'n')
    end,
    { desc = "sed leading whitespace" }
)
-- Append to the end of the line
vim.keymap.set('v', '<leader>sa', function()
        vim.fn.feedkeys(':s/\\(.*\\)/\\1', 'n')
    end,
    { desc = "sed append to all lines" }
)

-- copy first workd of each line
vim.keymap.set('v', '<leader>fw', function()
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end

    local words = {}
    for i = start_line, end_line do
        local line = vim.fn.getline(i)
        local word = line:match("([^%s:=,;{}()%[%]<>]+)")
        if word then table.insert(words, word) end
    end

    vim.fn.setreg("+", table.concat(words, "\n"))
    print("Copied first word(s) to clipboard")
end, { desc = "Copy first word of each line to clipboard" })

-- doc string generation

vim.keymap.set('n', '<leader>nf', function() require('neogen').generate({ type = "func" }) end,
    { desc = "Document function" })
vim.keymap.set('n', '<leader>nc', function() require('neogen').generate({ type = "class" }) end,
    { desc = "Document class" })
vim.keymap.set('n', '<leader>nl', function() require('neogen').generate({ type = "file" }) end,
    { desc = "Document file" })
vim.keymap.set('n', '<leader>nt', function() require('neogen').generate({ type = "type" }) end,
    { desc = "Document type" })

-- LSP commands feedback
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = "Show diagnostic at cursor" })
vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { desc = "LSP hover to show types etc..." })
vim.keymap.set('n', '<leader>lrf', function()
        telescope_builtin.lsp_references({
            layout_strategy = 'vertical',
            layout_config = {
                anchor = "E",
                width = 0.5,
                height = 0.9,
                prompt_position = "bottom",
            },
        })
        vim.keymap.set('n', '<leader>lrr', require('telescope.builtin').resume, { desc = "Resume last Telescope search" })
    end, -- vim.lsp.buf.references,
    { desc = "Show references" })
vim.keymap.set('n', '<leader>lrn', vim.lsp.buf.rename, { desc = "Rename", noremap = true, silent = false })

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    -- go to insert mode by default
    -- vim.api.nvim_input('i')
    -- ctrl + W to enter window mode (skip the ctrl \ + ctrl n)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-W>]], { noremap = true, silent = true })
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Hack so terminal renders 'right' of tree... probably doesn't belong here...
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        local Terminal = require('toggleterm.terminal').Terminal
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


local tidal = require("nvim-tidal")
vim.keymap.set("n", "<leader>te", function()
    tidal.evaluate_block()
end, { desc = "Tidal Evaluate Block" })
vim.keymap.set("n", "<leader>ts", function()
    tidal.start()
end, { desc = "Tidal Evaluate Block" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "haskell",
    callback = function()
        vim.keymap.set({ "i", "n" }, "<C-S>", function()
            require("nvim-tidal").evaluate_block()
        end, { buffer = true, desc = "Tidal Evaluate Block" })
    end,
})


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
