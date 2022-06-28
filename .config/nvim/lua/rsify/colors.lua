vim.opt.termguicolors = true -- real colors
vim.cmd('colorscheme dracula')
vim.g.dracula_full_special_attrs_support = 1
vim.cmd('hi CursorLine guibg=#303241')

vim.api.nvim_create_autocmd("BufWinEnter", { -- highlight extra whitespace
	pattern = "*",
	callback = function ()
		vim.cmd('hi ExtraWhitespace gui=underline,bold guifg=red')
		vim.cmd('match ExtraWhitespace /\\s\\+$/')
	end
})
