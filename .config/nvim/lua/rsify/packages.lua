-- source this file using `:source`
-- update/install packages `:PackerSync`

-- bootstrap packer
-- https://github.com/wbthomason/packer.nvim/tree/4dedd3b08f8c6e3f84afbce0c23b66320cd2a8f2#bootstrapping
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'                -- packer.nvim manages itself

	use 'AndrewRadev/switch.vim'                -- toggle true/false, js' function vs const, etc.
	use 'APZelos/blamer.nvim'                   -- inline git blame, toggle with `:BlamerToggle`
	use 'airblade/vim-gitgutter'                -- git info in gutter
	use 'christoomey/vim-sort-motion'           -- `gsip`
	use 'dracula/vim'                           -- color scheme
	use 'github/copilot.vim'                    -- copilot
	use 'junegunn/fzf.vim'                      -- `:Files`, `:Buffers`, etc

	use { 'nvim-telescope/telescope.nvim', requires = {
		{'nvim-lua/plenary.nvim'}
	} }

	use 'crispgm/telescope-heading.nvim'

	use 'markonm/traces.vim'                    -- preview range, pattern, substitute
	use 'tmux-plugins/vim-tmux-focus-events'    -- trigger vim enter events in tmux
	-- use 'tpope/vim-commentary'                  -- comments
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
	use 'nvim-treesitter/playground'
	use {                                       -- completion engine & more
		'neoclide/coc.nvim', branch = 'release'
	}
	use { 'kana/vim-textobj-user', requires = { -- text objects
		'kana/vim-textobj-line',
		'kana/vim-textobj-indent',
		'kana/vim-textobj-entire'
	} }
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end)

-- enable treesitter
require('nvim-treesitter.configs').setup {
	indent = {
		enable = true
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false
	},
	playground = {
		enable = true
	}
}

vim.g.switch_custom_definitions = {{'TRUE', 'FALSE'}}

local actions = require('telescope.actions')
require('telescope').setup({
	extensions = {
		heading = {
			treesitter = true,
		}
	},
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close
			},
		},
	}
})

require('telescope').load_extension('heading')
