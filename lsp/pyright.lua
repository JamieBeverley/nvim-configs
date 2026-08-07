-- Pick pyright's python interpreter, in order of preference:
--   1) a venv in the directory nvim was opened in (cwd)
--   2) a venv at the git repo root, if we're in one
--   3) nothing -- pyright falls back to whatever `python` is on PATH
-- Note: pyright's own root_dir is resolved from root_markers (pyproject.toml,
-- .git, ...), so it is *not* the cwd -- we have to look both up explicitly.

local VENV_DIRS = { '.venv', 'venv', 'env' }

---@param dir string
---@return string? interpreter absolute path to the venv's python
local function find_venv_python(dir)
    for _, name in ipairs(VENV_DIRS) do
        local py = dir .. '/' .. name .. '/bin/python'
        if vim.fn.executable(py) == 1 then
            return vim.fn.fnamemodify(py, ':p')
        end
    end
end

local function git_root(from)
    local dir = vim.fs.find('.git', { path = from, upward = true })[1]
    return dir and vim.fs.dirname(dir) or nil
end

return {
    before_init = function(_, config)
        local cwd = vim.fn.getcwd()

        -- pyrightconfig.json wins over anything we'd guess
        for _, dir in ipairs({ cwd, config.root_dir }) do
            if type(dir) == 'string' and vim.fn.filereadable(dir .. '/pyrightconfig.json') == 1 then
                return
            end
        end

        local python = find_venv_python(cwd)
        if not python then
            local root = git_root(cwd)
            if root and root ~= cwd then
                python = find_venv_python(root)
            end
        end
        if not python then return end -- system interpreter

        -- Mutate in place: the client captured a reference to this table before
        -- before_init ran, so reassigning config.settings would be a no-op.
        config.settings = config.settings or {}
        config.settings.python = config.settings.python or {}
        config.settings.python.pythonPath = python
    end,
}
