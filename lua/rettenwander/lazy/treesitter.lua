return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"vimdoc",
			"typescript",
			"javascript",
			"lua",
			"c",
			"bash",
			"go",
			"markdown",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					vim.notify(
						"File larger than 100KB treesitter disabled for performance",
						vim.log.levels.WARN,
						{ title = "Treesitter" }
					)
					return true
				end
			end,

			additional_vim_regex_highlighting = { "markdown" },
		},
		indent = {
			enable = true,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
