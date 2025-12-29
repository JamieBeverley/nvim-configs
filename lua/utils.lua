local color_emojis = {
  "🟥", -- red
  "🟧", -- orange
  "🟨", -- yellow
  "🟩", -- green
  "🟦", -- blue
  "🟪", -- purple
}

local function hash_string(str)
  local hash = 0
  for i = 1, #str do
    hash = (hash * 31 + str:byte(i)) % 2^31
  end
  return hash
end

local function project_title()
  local cwd = vim.fn.getcwd(-1, -1)
  local hash = hash_string(cwd)
  local emoji = color_emojis[(hash % #color_emojis) + 1]
  local project = vim.fn.fnamemodify(cwd, ":t")

  return string.format("%s %s", emoji, project)
end

_G.jamie_utils = {
    project_title = project_title
}

