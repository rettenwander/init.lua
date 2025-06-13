return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
            async = true,
            lsp_fallback = true,
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt" },
			},
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
		});
	end,
}
