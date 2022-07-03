vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function ()
		vim.cmd('set linebreak')
	end
})
