-- Disable mouse
vim.opt.mouse = ''

-- Read file changes on vim focus, disable swap file to allow multiple nvim's to
-- edit the same file
vim.opt.autoread = true
vim.opt.swapfile = false

-- Keep cursor vertically centered
vim.opt.scrolloff = 999

-- Disable timeout on chained keypresses (e.g. `,f`)
vim.opt.timeout = false

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

-- disable copilot by default, toggle in bindings.lua
vim.g.copilot_enabled = 0
vim.g.copilot_no_tab_map = true
