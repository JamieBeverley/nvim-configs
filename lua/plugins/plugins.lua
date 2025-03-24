

return {
    { "neovim/nvim-lspconfig" }, 
	{ "folke/which-key.nvim" },
	{ "sharkdp/fd" },
	{
		"nvim-treesitter/nvim-treesitter",
	build = function()
		require("nvim-treesitter.install").update({ with_syinc = true})()
	end,
	opts = {
		ensure_installed = { "javascript", "python", "typescript", "html", "css", "lua" },
		highlight = { enable = true },
		indent = { enable = true },
	}
},
{ 
	"nvim-telescope/telescope.nvim",
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter', 'sharkdp/fd' }
}
}
