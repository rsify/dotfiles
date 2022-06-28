-- heavily inspired by https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
-- tiny bit scuffed

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

		-- escape characters in cwd for replacing
		local escaped_cwd = cwd:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")

		-- must destructure like this because string.gsub returns two args
		local r = string.gsub(full_file_path, "^"..escaped_cwd,cwd_color..cwd..relative_color)

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
