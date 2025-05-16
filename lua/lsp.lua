
-- Formatters
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
    },
})

-- LSP
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
-- lspconfig.basedpyright.setup {
--       settings = {
--          basedpyright = {
--  
--          }
--      }
-- }
--

-- lspconfig.pyright.setup({
--   root_dir = util.root_pattern('pyrightconfig.json', 'pyproject.toml', '.git'),
-- 
--   before_init = function(_, config)
--     local root = config.root_dir
--     local pyright_config = root .. '/pyrightconfig.json'
--     local has_pyright_config = vim.fn.filereadable(pyright_config) == 1
-- 
--     if not has_pyright_config then
--       print("didn't find pyrightconfig.json, defaulting venv path to .venv")
--       print(root)
--       config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
--         python = {
--           venvPath = root,
--           venv = ".venv",
--         }
--       })
--     end
--   end,
-- })

local root_pattern = util.root_pattern('pyrightconfig.json', 'pyproject.toml', '.git')

lspconfig.pyright.setup({
  root_dir = root_pattern,
  settings = (function()
    local root = root_pattern(vim.fn.getcwd())
    local pyright_config = root and root .. '/pyrightconfig.json'
    local has_pyright_config = pyright_config and vim.fn.filereadable(pyright_config) == 1
    if has_pyright_config then
      return {} -- Don't override; let pyrightconfig.json handle it
    else
      return {
        python = {
          venvPath = root,
          venv = root .. ".venv",
        }
      }
    end
  end)()
})

lspconfig.ts_ls.setup{}
lspconfig.hls.setup{
    filetypes = { 'haskell', 'lhaskell', 'cabal' }
}

