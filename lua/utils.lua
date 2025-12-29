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
    hash = (hash * 31 + str:byte(i)) % 2^31
  end
  return hash
end

local function pick_emoji(cwd)
  for _, rule in ipairs(color_overrides) do
    if cwd == rule.pattern then
      return rule.emoji
    end
  end
  print("didn't find emoji")
  print(cwd)
  print(vim.inspect(color_overrides))
  return color_emojis[(hash_string(cwd) % #color_emojis) + 1]
end

local function project_title()
  local cwd = vim.fn.getcwd(-1, -1)
  return string.format("%s %s", pick_emoji(cwd), vim.fn.fnamemodify(cwd, ":t"))
end

_G.jamie_utils = { project_title = project_title, color_overrides=color_overrides }
