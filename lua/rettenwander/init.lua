require("rettenwander.set")
require("rettenwander.remap")
require("rettenwander.lazy_init")

local augroup = vim.api.nvim_create_augroup
local RettenwanderGroup = augroup("Rettenwander", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = yank_group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("LspAttach", {
	group = RettenwanderGroup,
	callback = function(e)
        local opts = {buffer = e.buf}

		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, opts)
		vim.keymap.set("n", "rn", function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	end,
})
