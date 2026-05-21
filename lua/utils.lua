local color_emojis = {
    "🟥", "🟧", "🟨", "🟩", "🟦", "🟪",
    "🔴", "🟠", "🟡", "🟢", "🔵", "🟣",
    "🔶", "🔷",
}

local ok, color_overrides = pcall(require, "jamie_local.color_overrides")
if not ok then color_overrides = {} end

local function hash_string(str)
    local hash = 0
    for i = 1, #str do
        hash = (hash * 31 + str:byte(i)) % 2 ^ 31
    end
    return hash
end

local function pick_emoji(cwd)
    for _, rule in ipairs(color_overrides) do
        if cwd == rule.pattern then
            return rule.emoji
        end
    end
    return color_emojis[(hash_string(cwd) % #color_emojis) + 1]
end

local function get_git_root(cwd)
    local result = vim.fn.systemlist(
        'git -C ' .. vim.fn.shellescape(cwd) .. ' rev-parse --git-common-dir 2>/dev/null'
    )
    if vim.v.shell_error ~= 0 or #result == 0 then
        return nil
    end
    local common_dir = result[1]
    -- --git-common-dir is relative (".git") for the main worktree, absolute for linked worktrees
    if not common_dir:match('^/') then
        common_dir = cwd .. '/' .. common_dir
    end
    return vim.fn.fnamemodify(common_dir, ':h')
end

local function project_title()
    local cwd = vim.fn.getcwd(-1, -1)
    local git_root = get_git_root(cwd)
    local repo_emoji = pick_emoji(git_root or cwd)
    local dir_emoji = pick_emoji(cwd)
    return string.format("%s%s %s", repo_emoji, dir_emoji, vim.fn.fnamemodify(cwd, ":t"))
end

_G.jamie_utils = { project_title = project_title, color_overrides = color_overrides }
