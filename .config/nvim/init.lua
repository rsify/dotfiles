vim.cmd('language en_US.UTF-8')

-- bootstrap packer.nvim
-- https://github.com/wbthomason/packer.nvim/tree/4dedd3b08f8c6e3f84afbce0c23b66320cd2a8f2#bootstrapping
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'                -- packer.nvim manages itself
	use 'APZelos/blamer.nvim'                   -- inline git blame, toggle with `:BlamerToggle`
	use 'airblade/vim-gitgutter'                -- git info in gutter
	use 'christoomey/vim-sort-motion'           -- `gsip`
	use 'dracula/vim'                           -- color scheme
	use 'github/copilot.vim'                    -- copilot
	use 'junegunn/fzf.vim'                      -- `:Files`, `:Buffers`, etc
	use 'markonm/traces.vim'                    -- preview range, pattern, substitute
	use 'tmux-plugins/vim-tmux-focus-events'    -- trigger vim enter events in tmux
	use 'tpope/vim-commentary'                  -- comments
	use 'tpope/vim-eunuch'                      -- unix style utilities, such as :Rename
	use 'tpope/vim-repeat'                      -- repeat
	use 'tpope/vim-sleuth'                      -- auto detect indent settings
	use 'tpope/vim-surround'                    -- surround
	use 'tpope/vim-vinegar'                     -- netrw integration
	use 'vim-scripts/ReplaceWithRegister'       -- `griw`
	use {                                       -- v nice syntax highlighting/indent
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use {                                       -- completion engine & more
		'neoclide/coc.nvim', branch = 'release'
	}
	use { 'kana/vim-textobj-user', requires = { -- text objects
		'kana/vim-textobj-line',
		'kana/vim-textobj-indent',
		'kana/vim-textobj-entire'
	} }

	if packer_bootstrap then
		require('packer').sync()
	end
end)

-- enable treesitter
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false
	}
}

-- Colors
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

-- statusline
-- heavily inspired by https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
Statusline = {}

Statusline.active = function()
	local modified = vim.o.modified

	local function mode()
		local modes = {
			["n"]  = {"NORMAL", "DraculaPurpleBold"},
			["no"] = {"NORMAL", "DraculaPurpleBold"},
			["v"]  = {"VISUAL", "DraculaGreenBold"},
			["V"]  = {"V LINE", "DraculaGreenBold"},
			[""] = {"VBLOCK", "DraculaGreenBold"},
			["s"]  = {"SELECT", "DraculaPinkItalic"},
			["S"]  = {"S LINE", "DraculaPinkItalic"},
			[""] = {"SBLOCK", "DraculaPinkItalic"},
			["i"]  = {"INSERT", "DraculaOrangeBold"},
			["ic"] = {"INSERT", "DraculaOrangeBold"},
			["R"]  = {"RPLACE", "DraculaRed"},
			["Rv"] = {"VRPLCE", "DraculaRed"},
			["c"]  = {"COMMND", "DraculaCommentBold"},
			["cv"] = {"VIM EX", "DraculaCommentBold"},
			["ce"] = {"EX MOD", "DraculaCommentBold"},
			["r"]  = {"PROMPT", "DraculaCommentBold"},
			["rm"] = {"MOARRR", "DraculaCommentBold"},
			["r?"] = {"CONFRM", "DraculaCommentBold"},
			["!"]  = {"!SHELL", "DraculaCommentBold"},
			["t"]  = {"TERMNL", "DraculaCommentBold"},
		}

		local current_mode = vim.api.nvim_get_mode().mode

		local label = modes[current_mode][1]
		local highlight = modes[current_mode][2]

		return "%#"..highlight.."#".."["..label.."]"
	end

	local function readonly()
		if vim.o.readonly then
			return "%#DraculaRed#[ro] "
		else
			return ""
		end
	end

	-- if the full filepath starts with the cwd, highlight the cwd part of the
	-- path in one color, and the rest in another.
	-- otherwise, show the full path in a dim color.
	local function file()
		local full_file_path = vim.fn.expand("%:p")
		local cwd = vim.fn.getcwd()

		-- append "/" if cwd doesn't end with "/"
		if cwd:sub(-1) ~= "/" then
			cwd = cwd .. "/"
		end

		local cwd_color = "%%#DraculaCyan#"
		local relative_color = modified and "%%#DraculaOrangeBold#" or "%%#DraculaOrange#"

		-- must destructure like this because string.gsub returns two args
		local r = string.gsub(full_file_path, "^"..cwd,cwd_color..cwd..relative_color)

		return table.concat {
			modified and "%#DraculaCommentBold#" or "%#DraculaComment#",
			r
		}
	end

	local function coc()
		if vim.g.coc_enabled == 0 then
			return "[coc:n]"
		end

		return "[" .. vim.api.nvim_eval('coc#status()') .. "]"
	end

	local function copilot_status()
		if vim.api.nvim_eval('copilot#Enabled()') == 1 then
			return "[co:y]"
		else
			return "[co:n]"
		end
	end

	local function file_type()
		local ft = vim.bo.filetype
		if ft == "" then
			return "[no ft]"
		else
			return "["..ft.."]"
		end
	end

	local function line_info()
		return "[%c|%P]"
	end

	return table.concat {
		mode(),
		" ",
		readonly(),
		file(),
		modified and "%#DraculaGreenBold# [+]" or "",
		"%= ",
		"%#Normal#",
		coc(),
		" ",
		copilot_status(),
		" ",
		file_type(),
		" ",
		line_info(),
	}
end

function Statusline.inactive()
	return " %F"
end

vim.api.nvim_exec([[
	augroup Statusline
		au!
		au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
		au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
	augroup END
]], false)


-- Read file changes on vim focus, disable swap file to allow multiple nvim's to
-- edit the same file
vim.opt.autoread = true
vim.opt.swapfile = false

-- Keep cursor vertically centered
vim.opt.scrolloff = 999

-- Update gitgutter in real time-ish
vim.opt.updatetime = 100

-- Disable `-- INSERT --` message
vim.opt.showmode = false

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight current line
vim.opt.cursorline = true

-- Ignore search case if only lower case characters, otherwise be case sensitive
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Make `vnew` & `new` open windows to the right & bottom
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 4 char wide indents
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Indent broken up lines by 4 chars
vim.opt.breakindent = true
vim.opt.breakindentopt = 'shift:4'

-- Make all folds based on indents, and disable them on file open (`zi` to toggle)
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false

-- always display sign column/gutter so that there's no cursor jumperino
vim.opt.signcolumn = 'yes'

-- disables the ~/.viminfo file. viminfo/shada stores some state across vim startups, see `:h shada`/`:h viminfo` for more.
vim.opt.shada = ''

if vim.fn.hostname() == 'ryrz' then
	vim.api.nvim_set_option('clipboard', 'unnamedplus')
end

-- blamer.nvim delay before showing the blame line. Toggle with `:BlamerToggle`, disabled by default.
vim.g.blamer_delay = 400

-- disable copilot by default, toggle with <leader>g
vim.g.copilot_enabled = 0
vim.g.copilot_no_tab_map = true

-- mappings (https://github.com/nanotee/nvim-lua-guide#defining-mappings)
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
vim.api.nvim_set_keymap('n', '<esc>',     ':nohlsearch<return><esc>',           { silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b', '<Plug>(coc-references)',             { silent = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':CocDiagnostics<CR>',                { silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', '<Plug>(coc-definition)',             { silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>',                         { silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', 'nil',                                { callback = toggle_copilot })
vim.api.nvim_set_keymap('n', '<leader>r', '<Plug>(coc-rename)',                 { silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', '<Plug>(coc-type-definition)',        { silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':CocFix<CR>',                        { silent = true })
vim.api.nvim_set_keymap('n', '<space>',   ':Buffers<CR>',                       { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'K',         '',                                   { callback = show_documentation })
vim.api.nvim_set_keymap('n', '[g',        '<Plug>(coc-diagnostic-prev)',        { silent = true })
vim.api.nvim_set_keymap('n', ']g',        '<Plug>(coc-diagnostic-next)',        { silent = true })
