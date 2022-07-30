-- https://github.com/nanotee/nvim-lua-guide#defining-mappings
function toggle_copilot()
	if vim.api.nvim_eval('copilot#Enabled()') == 1 then
		vim.cmd('Copilot disable')
	else
		vim.cmd('Copilot enable')
	end
end

function show_documentation()
	if vim.fn.CocAction('hasProvider', 'hover') then
		vim.fn.CocActionAsync('doHover')
	else
		vim.fn.feedkeys('K', 'in')
	end
end

vim.cmd("command! -nargs=* -range CocFix    :call CocActionAsync('codeActionRange', <line1>, <line2>, 'quickfix')")

vim.g.mapleader = ','

vim.api.nvim_set_keymap('i', '<c-j>',     'copilot#Accept("<CR>")',             { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'coc#refresh()',                      { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<cr>',      '<c-g>u<cr><c-r>=coc#on_enter()<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<c-h>',     '<c-w>h',                             { silent = true })
vim.api.nvim_set_keymap('n', '<c-j>',     '<c-w>j',                             { silent = true })
vim.api.nvim_set_keymap('n', '<c-k>',     '<c-w>k',                             { silent = true })
vim.api.nvim_set_keymap('n', '<c-l>',     '<c-w>l',                             { silent = true })
vim.api.nvim_set_keymap('n', '<c-q>',     ':q<CR>',                             { silent = true })
vim.api.nvim_set_keymap('n', '<c-s>',     ':w<CR>',                             { silent = true })
vim.api.nvim_set_keymap('n', '<c-w>_',    '<c-w>s',                             { silent = true })
vim.api.nvim_set_keymap('n', '<c-w>_',    '<c-w>s',                             { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<c-w>|',    '<c-w>v',                             { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<esc>',     ':nohlsearch<return><esc>',           { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>F', ':Telescope git_files<CR>',           { silent = true })
vim.api.nvim_set_keymap('n', '<leader>a', '<Plug>(coc-codeaction)',             { silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', '<Plug>(coc-references)',             { silent = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':CocList --normal --auto-preview diagnostics<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', '<Plug>(coc-definition)',             { silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':CocListResume<CR>',                 { silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<CR>',          { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>g', 'nil',                                { callback = toggle_copilot })
vim.api.nvim_set_keymap('n', '<leader>q', '<Plug>(coc-fix-current)',            { silent = true })
vim.api.nvim_set_keymap('n', '<leader>r', '<Plug>(coc-rename)',                 { silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', '<Plug>(coc-type-definition)',        { silent = true })
vim.api.nvim_set_keymap('n', '<leader>v', ':Telescope live_grep<CR>',           { silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':CocFix<CR>',                        { silent = true })
vim.api.nvim_set_keymap('n', '<leader>y', ':Telescope heading theme=ivy initial_mode=normal scroll_strategy=limit<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<space>',   ':Telescope buffers<CR>',             { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'K',         '',                                   { callback = show_documentation })
vim.api.nvim_set_keymap('n', '[g',        '<Plug>(coc-diagnostic-prev)',        { silent = true })
vim.api.nvim_set_keymap('n', ']g',        '<Plug>(coc-diagnostic-next)',        { silent = true })
vim.api.nvim_set_keymap('n', 'g[',        ':CocPrev<CR>',                       { silent = true })
vim.api.nvim_set_keymap('n', 'g]',        ':CocNext<CR>',                       { silent = true })

vim.g.switch_mapping = '\\' -- switch.vim
