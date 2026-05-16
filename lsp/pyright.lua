return {
    before_init = function(params, config)
        local root = params.rootPath
        if not root then return end

        if vim.fn.filereadable(root .. '/pyrightconfig.json') == 1 then
            return -- let pyrightconfig.json handle it
        end

        if vim.fn.isdirectory(root .. '/.venv') == 1 then
            config.settings = vim.tbl_deep_extend('force', config.settings or {}, {
                python = { venvPath = root, venv = '.venv' }
            })
        end
    end,
}
